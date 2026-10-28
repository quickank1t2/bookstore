const cds = require('@sap/cds')

module.exports = class AdminService extends cds.ApplicationService {
  async init() {
    const { Books, Orders, OrderItems } = this.entities

    this.on('submitOrder', async (req) => {
      const { orderID } = req.data

      const order = await SELECT.one.from(Orders).where({ ID: orderID })
      if (!order) return req.error(404, `Order ${orderID} not found`)
      if (order.status === 'FULFILLED' || order.status === 'CANCELLED')
        return req.error(409, `Order is already ${order.status}`)

      const items = await SELECT.from(OrderItems).where({ parent_ID: orderID })
      if (!items.length) return req.error(400, 'Order has no items')

      for (const item of items) {
        const book = await SELECT.one.from(Books).where({ ID: item.book_ID })
        if (!book) return req.error(404, `Book ${item.book_ID} not found`)
        if (book.stock < item.quantity)
          return req.error(409, `Insufficient stock for "${book.title}": ${book.stock} available, ${item.quantity} requested`)
      }

      for (const item of items) {
        const book = await SELECT.one.from(Books).where({ ID: item.book_ID })
        await UPDATE(Books).set({ stock: book.stock - item.quantity }).where({ ID: item.book_ID })
        await UPDATE(OrderItems).set({ netAmount: item.quantity * book.price }).where({ ID: item.ID })
      }

      await UPDATE(Orders).set({ status: 'FULFILLED' }).where({ ID: orderID })
      return `Order ${orderID} fulfilled successfully`
    })

    this.on('cancelOrder', async (req) => {
      const { orderID } = req.data

      const order = await SELECT.one.from(Orders).where({ ID: orderID })
      if (!order) return req.error(404, `Order ${orderID} not found`)
      if (order.status === 'CANCELLED')
        return req.error(409, 'Order is already cancelled')

      const items = await SELECT.from(OrderItems).where({ parent_ID: orderID })

      // Only restock if stock was previously decremented (FULFILLED state)
      if (order.status === 'FULFILLED') {
        for (const item of items) {
          const book = await SELECT.one.from(Books).where({ ID: item.book_ID })
          if (book) {
            await UPDATE(Books).set({ stock: book.stock + item.quantity }).where({ ID: item.book_ID })
          }
        }
      }

      await UPDATE(Orders).set({ status: 'CANCELLED' }).where({ ID: orderID })
      return `Order ${orderID} cancelled`
    })

    return super.init()
  }
}

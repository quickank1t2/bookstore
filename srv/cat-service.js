const cds = require('@sap/cds')

module.exports = class CatalogService extends cds.ApplicationService {
  async init() {
    this.before('READ', 'Books', (req) => {
      // Example BEFORE hook: log who is reading books
      req.info(`Books read by: ${req.user?.id ?? 'anonymous'}`)
    })

    return super.init()
  }
}

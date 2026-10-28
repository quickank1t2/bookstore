using AdminService from '../../srv/admin-service';

annotate AdminService.Orders with @(
  UI.LineItem: [
    { Value: customer              },
    { Value: status                },
    { Value: createdAt, Label: 'Created' },
    {
      $Type:  'UI.DataFieldForAction',
      Action: 'AdminService.submitOrder',
      Label:  'Submit Order'
    },
    {
      $Type:  'UI.DataFieldForAction',
      Action: 'AdminService.cancelOrder',
      Label:  'Cancel Order'
    }
  ],
  UI.HeaderInfo: {
    TypeName:       'Order',
    TypeNamePlural: 'Orders',
    Title:          { Value: customer },
    Description:    { Value: status   }
  },
  UI.Facets: [
    {
      $Type:  'UI.ReferenceFacet',
      Label:  'Order Details',
      Target: '@UI.FieldGroup#OrderDetails'
    },
    {
      $Type:  'UI.ReferenceFacet',
      Label:  'Items',
      Target: 'items/@UI.LineItem'
    }
  ],
  UI.FieldGroup#OrderDetails: {
    Data: [
      { Value: customer  },
      { Value: status    },
      { Value: createdAt }
    ]
  }
);

annotate AdminService.OrderItems with @(
  UI.LineItem: [
    { Value: book_ID,   Label: 'Book'       },
    { Value: quantity,  Label: 'Quantity'   },
    { Value: netAmount, Label: 'Net Amount' }
  ]
);

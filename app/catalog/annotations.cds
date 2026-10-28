using CatalogService from '../../srv/cat-service';

annotate CatalogService.Books with @(
  UI.LineItem: [
    { Value: title },
    { Value: author.name,  Label: 'Author' },
    { Value: genre.name,   Label: 'Genre'  },
    { Value: price,        Label: 'Price'  },
    { Value: stock,        Label: 'Stock'  }
  ],
  UI.HeaderInfo: {
    TypeName:       'Book',
    TypeNamePlural: 'Books',
    Title:          { Value: title },
    Description:    { Value: author.name }
  },
  UI.Facets: [
    {
      $Type:  'UI.ReferenceFacet',
      Label:  'Details',
      Target: '@UI.FieldGroup#Details'
    }
  ],
  UI.FieldGroup#Details: {
    Data: [
      { Value: title  },
      { Value: author_ID, Label: 'Author' },
      { Value: genre_ID,  Label: 'Genre'  },
      { Value: price  },
      { Value: stock  },
      { Value: descr  }
    ]
  }
);

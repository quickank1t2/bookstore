sap.ui.define(['sap/fe/core/AppComponent'], (AppComponent) => {
  'use strict'
  return AppComponent.extend('my.bookshop.catalog', {
    metadata: {
      interfaces: ['sap.ui.core.IAsyncContentCreation'],
      manifest: 'json'
    }
  })
})

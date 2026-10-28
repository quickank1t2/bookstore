using my.bookshop as my from '../db/schema';

@path: 'catalog'
service CatalogService @(requires: 'Viewer') {
  @readonly entity Books   as projection on my.Books;
  @readonly entity Authors as projection on my.Authors;
  @readonly entity Genres  as projection on my.Genres;
}

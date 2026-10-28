using my.bookshop as my from '../db/schema';

@path: 'admin'
service AdminService @(requires: 'Admin') {
  entity Books      as projection on my.Books;
  entity Authors    as projection on my.Authors;
  entity Genres     as projection on my.Genres;
  entity Orders     as projection on my.Orders;
  entity OrderItems as projection on my.OrderItems;

  action submitOrder(orderID: UUID) returns String;
  action cancelOrder(orderID: UUID) returns String;
}

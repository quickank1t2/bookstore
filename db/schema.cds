namespace my.bookshop;
using { cuid } from '@sap/cds/common';

entity Authors {
  key ID        : Integer;
  name          : String(111);
  dateOfBirth   : Date;
  placeOfBirth  : String;
  biography     : String(1111);
  books         : Association to many Books on books.author = $self;
}

entity Genres {
  key ID   : Integer;
  name     : String(100);
  descr    : String(500);
}

entity Books {
  key ID   : Integer;
  title    : String(111);
  author   : Association to Authors;
  genre    : Association to Genres;
  stock    : Integer;
  price    : Decimal(9,2);
  descr    : String(1111);
}

type OrderStatus : String enum {
  NEW        = 'NEW';
  PROCESSING = 'PROCESSING';
  FULFILLED  = 'FULFILLED';
  CANCELLED  = 'CANCELLED';
}

entity Orders : cuid {
  createdAt : DateTime @cds.on.insert: $now;
  status    : OrderStatus default 'NEW';
  customer  : String(100);
  items     : Composition of many OrderItems on items.parent = $self;
}

entity OrderItems : cuid {
  parent    : Association to Orders;
  book      : Association to Books;
  quantity  : Integer;
  netAmount : Decimal(9,2);
}

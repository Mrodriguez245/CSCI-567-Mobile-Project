import 'package:flutter/foundation.dart';

DeliItemList deliitemList = DeliItemList(deliItems: [
  DeliItem(
    id: 1,
    title: "First item",
    place: "Test place",
    price: 14.49,
    imgUrl:
    "https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/480x240/54ca71fb94ad3_-_5summer_skills_burger_470_0808-de.jpg",
  ),
]);

class DeliItemList {
  List<DeliItem> deliItems;

  DeliItemList({@required this.deliItems});
}

class DeliItem {
  int id;
  String title;
  String place;
  double price;
  String imgUrl;
  int quantity;

  DeliItem({
             @required this.id,
             @required this.title,
             @required this.place,
             @required this.price,
             @required this.imgUrl,
             this.quantity = 1,
           });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
import 'package:deliapplication/model/deliitem.dart';

class CartProvider {
  List<DeliItem> deliItems = [];

  List<DeliItem> addToList(DeliItem deliItem) {
    deliItems.add(deliItem);
    return deliItems;
  }

  List<DeliItem> removeFromList(DeliItem deliItem) {
    deliItems.remove(deliItem);
    return deliItems;
  }
}
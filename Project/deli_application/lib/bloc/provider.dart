import 'package:deliapplication/model/deli_item.dart';
class CartProvider {
  List<DeliItem> deliItems = [];

  List<DeliItem> addToList(DeliItem deliItem) {
    bool isPresent = false;

    if (deliItems.length > 0) {
      for (int i = 0; i < deliItems.length; i++) {
        if (deliItems[i].id == deliItem.id) {
          increaseItemQuantity(deliItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        deliItems.add(deliItem);
      }
    } else {
      deliItems.add(deliItem);
    }

    return deliItems;
  }

  List<DeliItem> removeFromList(DeliItem deliItem) {
    if (deliItem.quantity > 1) {
      //only decrease the quantity
      decreaseItemQuantity(deliItem);
    } else {
      //remove it from the list
      deliItems.remove(deliItem);
    }
    return deliItems;
  }

  void increaseItemQuantity(DeliItem deliItem) => deliItem.incrementQuantity();
  void decreaseItemQuantity(DeliItem deliItem) => deliItem.decrementQuantity();
}
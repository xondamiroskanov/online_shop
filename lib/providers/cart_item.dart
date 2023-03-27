import 'package:flutter/cupertino.dart';
import 'package:online_shop/models/cart_item_model.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return _items;
  }

  int itemCount() {
    return _items.length;
  }

  String totalPrice() {
    int total = 0;
    _items.forEach((key, value) {
      total += int.parse(value.price);
    });
    return total.toString();
  }

  void addToProduct(
      String title, String image, String price, String productId) {
    if (_items.containsKey(productId)) {
      //sonini kopayt
      _items.update(
          productId,
          (value) => CartItem(
                title: value.title,
                price: value.price,
                image: value.image,
                number: value.number + 1,
                id: value.id,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          title: title,
          price: price,
          image: image,
          number: 1,
          id: UniqueKey().toString(),
        ),
      );
    }
    notifyListeners();
  }

  void minusProduct(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.number > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              title: value.title,
              price: value.price,
              image: value.image,
              number: value.number-1,
              id: value.id));
    }
    notifyListeners();
  }
}

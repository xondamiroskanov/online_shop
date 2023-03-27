import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/order_model.dart';

class OrderProduct with ChangeNotifier {
  List<Order> _orderItems = [];

  List<Order> get orderItems {
    return [..._orderItems];
  }

  void orderAddProduct(List<CartItem> products, double totalPrice) {
    _orderItems.insert(0, Order(id: UniqueKey().toString(),
        price: totalPrice,
        time: DateTime.now(),
        products: products));
    notifyListeners();
  }


}

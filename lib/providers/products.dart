import 'package:flutter/material.dart';

import '../models/product_model.dart';

class Products with ChangeNotifier {
  List<ProductModel> _productsList = [
    ProductModel(
        name: "Macbook Pro",
        price: "580 \$",
        description: "cori 5 ram 8",
        image:
        "https://images.unsplash.com/photo-1530893609608-32a9af3aa95c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8TWFjYm9vayUyMHByb3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        id: "p1"),
    ProductModel(
        name: "Iphone 12",
        price: "600 \$",
        description: "yomks 99 % gold color",
        image:
        "https://images.unsplash.com/photo-1609692814859-9ebe00526a8e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8aXBob25lJTIwMTIlMjBwcm98ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        id: "p2"),
    ProductModel(
        name: "Smart watch",
        price: "100 \$",
        description: "elektron smart watch",
        image:
        "https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c21hcnQlMjB3YXRjaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        id: "p3"),
  ];

  List<ProductModel> get productsList {
    return [..._productsList];
  }

  void addProduct() {
    notifyListeners();
  }
}

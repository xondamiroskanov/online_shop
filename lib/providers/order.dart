import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/cart_item_model.dart';
import '../models/order_model.dart';

class OrderProduct with ChangeNotifier {
  List<Order> _orderItems = [];

  List<Order> get orderItems {
    return [..._orderItems];
  }

  Future<void> orderAddProduct(
      List<CartItem> products, double totalPrice) async {
    final uri =
        Uri.parse("https://fir-81ed4-default-rtdb.firebaseio.com/orders.json");
    try {
      final res = await http.post(
        uri,
        body: jsonEncode(
          {
            "totalPrice": totalPrice,
            "date": DateTime.now().toIso8601String(),
            "products": products
                .map((e) => {
                      "title": e.title,
                      "price": e.price,
                      "number": e.number,
                      "image": e.image
                    })
                .toList(),
          },
        ),
      );
      _orderItems.insert(
        0,
        Order(
            id: jsonDecode(res.body)['name'],
            price: totalPrice,
            time: DateTime.now(),
            products: products),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getOrderProducts() async {
    final url =
        Uri.parse("https://fir-81ed4-default-rtdb.firebaseio.com/orders.json");

    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        final orderProductData =
            jsonDecode(response.body) as Map<String, dynamic>;
        List<Order> orderList = [];
        orderProductData.forEach((orderid, data) {
          orderList.insert(
            0,
            Order(
              id: orderid..toString(),
              price: double.parse(data["totalPrice"].toString()),
              time: DateTime.parse(data["date"].toString()),
              products: (data["products"] as List<dynamic>)
                  .map(
                    (orderData) => CartItem(
                      title: orderData["title"],
                      price: orderData["price"].toString(),
                      image: orderData["image"].toString(),
                      number: double.parse(orderData["number"].toString()),
                      id: orderData["id"].toString(),
                    ),
                  )
                  .toList(),
            ),
          );
        });
        _orderItems = orderList;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}

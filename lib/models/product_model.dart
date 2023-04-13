import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductModel with ChangeNotifier {
  final String name;
  final String price;
  final String description;
  final String image;
  final String id;
  bool isFavorite;

  ProductModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.id,
      this.isFavorite = false});

  Future<void> toogleDone() async {
    var oldFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final uri = Uri.parse(
        "https://fir-81ed4-default-rtdb.firebaseio.com/products/$id.json");
    try {
     final response =  await http.patch(
        uri,
        body: jsonEncode({'isFavorite': isFavorite}),
      );
      if(response.statusCode >=400){
        isFavorite = oldFavorite;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldFavorite;
      notifyListeners();
      rethrow;
    }
  }
}

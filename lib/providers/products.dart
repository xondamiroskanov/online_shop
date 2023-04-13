import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class Products with ChangeNotifier {
  List<ProductModel> _productsList = [];

  List<ProductModel> get productsList {
    return [..._productsList];
  }

  List<ProductModel> get favorite {
    return _productsList.where((element) => element.isFavorite).toList();
  }

  Future<void> getProducts() async {
    final uri = Uri.parse(
        "https://fir-81ed4-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.get(uri);
      if (jsonDecode(response.body) != null) {
        final productData = jsonDecode(response.body) as Map<String, dynamic>;
        List<ProductModel> loadedProduct = [];
        productData.forEach((productId, product) {
          loadedProduct.add(
            ProductModel(
              name: product['name'],
              price: product['price'],
              description: product['description'],
              image: product['image'],
              id: productId,
            ),
          );
        });
        _productsList = loadedProduct;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(ProductModel productModel) async {
    final uri = Uri.parse(
        "https://fir-81ed4-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.post(
        uri,
        body: jsonEncode(
          {
            "name": productModel.name,
            "price": productModel.price,
            "description": productModel.description,
            "image": productModel.image,
            "isFavorite": productModel.isFavorite
          },
        ),
      );
      _productsList.add(
        ProductModel(
          name: productModel.name,
          price: productModel.price,
          description: productModel.description,
          image: productModel.image,
          id: (jsonDecode(response.body) as Map<String, dynamic>)['name'],
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(ProductModel newProduct) async {
    final uri = Uri.parse(
        "https://fir-81ed4-default-rtdb.firebaseio.com/products/${newProduct.id}.json");
    final indexProduct =
        _productsList.indexWhere((element) => element.id == newProduct.id);
    if (indexProduct >= 0) {
      try {
        await http.patch(uri,
            body: jsonEncode({
              "name": newProduct.name,
              "price": newProduct.price,
              "description": newProduct.description,
              "image": newProduct.image
            }));
        _productsList[indexProduct] = newProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  Future<void> removeProductItem(removeId) async {
    final uri = Uri.parse(
        "https://fir-81ed4-default-rtdb.firebaseio.com/products/$removeId.json");
    try {
      var returnAddPro =
          _productsList.firstWhere((element) => element.id == removeId);
      final indexPro =
          _productsList.indexWhere((element) => element.id == removeId);
      _productsList.removeWhere((element) => element.id == removeId);
      notifyListeners();
      final response = await http.delete(uri);
      if (response.statusCode >= 400) {
        _productsList.insert(indexPro, returnAddPro);
        notifyListeners();
        throw HttpException(
            "Kechirasiz mahsulotni o'chirishda xatolik sodir bo'ldi");
      }
    } catch (error) {
      rethrow;
    }
  }
}

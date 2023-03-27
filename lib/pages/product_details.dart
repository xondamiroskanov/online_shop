import 'package:flutter/material.dart';
import 'package:online_shop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  static const routeName = "/productDetails";

  @override
  Widget build(BuildContext context) {
    final routeProductModel = ModalRoute.of(context)!.settings.arguments;
    final productPro = Provider.of<Products>(context)
        .productsList
        .firstWhere((element) => element.id == routeProductModel);
    print(routeProductModel);
    return Scaffold(
      appBar: AppBar(
        title: Text(productPro.name),
      ),
    );
  }
}

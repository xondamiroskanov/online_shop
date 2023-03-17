import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  static const routeName = "/productDetails";

  @override
  Widget build(BuildContext context) {
    final routeProductModel = ModalRoute.of(context)!.settings.arguments;
    print(routeProductModel);
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

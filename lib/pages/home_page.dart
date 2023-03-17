import 'package:flutter/material.dart';
import 'package:online_shop/providers/products.dart';
import 'package:online_shop/widgets/product_grid.dart';
import 'package:online_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My shop"),
      ),
      body: ProductGrid()
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    final productData = productProvider.productsList;
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: productData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2.5,
          mainAxisExtent: 400,
          crossAxisSpacing: 10),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.all(4),
            child: ProductItem(productModel: productData[index]));
      },
    );
  }
}

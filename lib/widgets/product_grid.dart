import 'package:flutter/material.dart';
import 'package:online_shop/models/product_model.dart';
import 'package:online_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  final bool isFavorite;
  const ProductGrid(this.isFavorite, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    final productData = isFavorite ? productProvider.favorite : productProvider.productsList;
    print(isFavorite);
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: productData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2.5,
          mainAxisExtent: 400,
          crossAxisSpacing: 10),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.all(4),
            child: ChangeNotifierProvider<ProductModel>.value(
                value: productData[index],
                child: ProductItem()));
      },
    );
  }
}

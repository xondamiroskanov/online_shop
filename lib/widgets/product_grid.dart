import 'package:flutter/material.dart';
import 'package:online_shop/models/product_model.dart';
import 'package:online_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductGrid extends StatefulWidget {
  final bool isFavorite;

  const ProductGrid(this.isFavorite, {Key? key}) : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late Future productFuture;
  Future getProductFuture() {
    return Provider.of<Products>(context, listen: false).getProducts();
  }

  @override
  void initState() {
    productFuture = getProductFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.error == null) {
            return Consumer<Products>(
              builder: (BuildContext context, productProvider, child) {
                final productData = widget.isFavorite
                    ? productProvider.favorite
                    : productProvider.productsList;
                return productData.length > 0
                    ? GridView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: productData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 3 / 2.5,
                                mainAxisExtent: 400,
                                crossAxisSpacing: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(4),
                            child: ChangeNotifierProvider<ProductModel>.value(
                              value: productData[index],
                              child: ProductItem(),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("Hozircha mahsulotlar qo'shilmagan"));
              },
            );
          } else {
            return const Center(
              child: Text("Xatolik yuz berdi"),
            );
          }
        }
      },
    );
  }
}

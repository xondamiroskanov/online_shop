import 'package:flutter/material.dart';
import 'package:online_shop/pages/product_details.dart';

import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;

  const ProductItem({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsPage.routeName,arguments: productModel.id);
          },
          child: Image.network(
            productModel.image,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
          ),
          backgroundColor: Colors.black45.withOpacity(0.5),
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                color: Theme.of(context).primaryColor,
              )),
          title: Text(
            productModel.name,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

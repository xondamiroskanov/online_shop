import 'package:flutter/material.dart';
import 'package:online_shop/pages/product_details.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_item.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModel>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailsPage.routeName, arguments: product.id);
          },
          child: Image.network(
            product.image,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          trailing: IconButton(
            onPressed: () {
              cart.addToProduct(
                  product.name, product.image, product.price, product.id);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
          ),
          backgroundColor: Colors.black45.withOpacity(0.5),
          leading: Consumer<ProductModel>(
            builder: (BuildContext context, pro, Widget? child) {
              return IconButton(
                  onPressed: () {
                    pro.toogleDone();
                  },
                  icon: Icon(
                    pro.isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: Colors.teal,
                  ));
            },
          ),
          title: Text(
            product.name,
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

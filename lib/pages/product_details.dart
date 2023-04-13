import 'package:flutter/material.dart';
import 'package:online_shop/pages/cart_shop_page.dart';
import 'package:online_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  static const routeName = "/productDetails";

  @override
  Widget build(BuildContext context) {
    final routeProductModel = ModalRoute.of(context)!.settings.arguments;
    final productPro = Provider.of<Products>(context)
        .productsList
        .firstWhere((element) => element.id == routeProductModel);
    return Scaffold(
      appBar: AppBar(
        title: Text(productPro.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 300,
                child: Image.network(
                  productPro.image,
                  fit: BoxFit.cover,
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                productPro.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16),
          height: 83,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Narxi:",
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                  ),
                  Text(
                    "${productPro.price} \$",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
              Consumer<Cart>(builder: (context, cart, child) {
                final isCartAddProduct = cart.items.containsKey(productPro.id);
                if (isCartAddProduct) {
                  return Container(
                    height: 50,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(CartShopPage.routeName);
                        },
                        icon: Icon(Icons.shopping_cart),
                        label: Text(
                          "Savatchaga borish",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  );
                } else {
                  return ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        cart.addToProduct(productPro.name, productPro.image,
                            productPro.price, productPro.id);
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text("Savatchaga qoshish"));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

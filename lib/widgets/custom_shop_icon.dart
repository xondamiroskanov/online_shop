import 'package:flutter/material.dart';
import 'package:online_shop/pages/cart_shop_page.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';

class CustomShopIcon extends StatelessWidget {
  const CustomShopIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CartShopPage.routeName);
          },
          icon: Icon(
            Icons.shopping_cart,
          ),
        ),
        Positioned(
          top: 4,
          right: 8,
          child: Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.centerRight,
            width: 12,
            height: 12,
            child: Consumer<Cart>(
              builder: (BuildContext context, cartCount, Widget? child) {
                return Center(
                  child: Text(
                    cartCount.itemCount().toString(),
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },

            ),
          ),
        ),
      ],
    );
  }
}

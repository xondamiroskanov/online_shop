import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';

class CartShopList extends StatelessWidget {
  const CartShopList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartShop = Provider.of<Cart>(context);
    final cartShopMap = cartShop.items;
    return Expanded(
      child: ListView.builder(
          itemCount: cartShopMap.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage:
                        NetworkImage(cartShopMap.values.toList()[index].image),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartShopMap.values.toList()[index].title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "Umumiy ${int.parse(cartShop.totalPrice()) * cartShopMap.values.toList()[index].number}\$",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          cartShop.minusProduct(
                              cartShop.items.keys.toList()[index]);
                        },
                        child: Text(
                          "-",
                          style: TextStyle(fontSize: 24, color: Colors.black87),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black12),
                        child: Text(cartShopMap.values
                            .toList()[index]
                            .number
                            .toString()),
                      ),
                      TextButton(
                        onPressed: () {
                          cartShop.addToProduct(
                              cartShopMap.values.toList()[index].title,
                              cartShopMap.values.toList()[index].image,
                              cartShopMap.values.toList()[index].price,
                              cartShop.items.keys.toList()[index]);
                        },
                        child: Text("+",
                            style:
                                TextStyle(fontSize: 24, color: Colors.black87)),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';
import '../widgets/cart_shop_list.dart';

class CartShopPage extends StatelessWidget {
  const CartShopPage({Key? key}) : super(key: key);
  static const routeName = "/cartShoPage";

  @override
  Widget build(BuildContext context) {
    final cartShop = Provider.of<Cart>(context);
    print(cartShop.itemCount());
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyirtmalar"),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            child: Card(
              elevation: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Umumiy",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),
                  Container(
                      height: 32,
                      width: 68,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(36)),
                      child: Center(
                        child: Text(
                          "${cartShop.totalPrice()} \$",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Buyirtma qilish",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CartShopList()
        ],
      ),
    );
  }
}

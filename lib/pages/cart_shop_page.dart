import 'package:flutter/material.dart';
import 'package:online_shop/pages/orders_page.dart';
import 'package:online_shop/providers/order.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';
import '../widgets/cart_shop_list.dart';

class CartShopPage extends StatefulWidget {
  const CartShopPage({Key? key}) : super(key: key);
  static const routeName = "/cartShoPage";

  @override
  State<CartShopPage> createState() => _CartShopPageState();
}

class _CartShopPageState extends State<CartShopPage> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartShop = Provider.of<Cart>(context);
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
                const Text(
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
                  onPressed:
                    cartShop.items.length > 0 ? () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Provider.of<OrderProduct>(context,
                        listen: false)
                        .orderAddProduct(cartShop.items.values.toList(),
                        double.parse(cartShop.totalPrice()));
                    setState(() {
                      isLoading = false;
                    });
                    cartShop.clear();
                    Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
                  }:null,
                  child: isLoading
                  ? CircularProgressIndicator()
                  : Text(
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/providers/order.dart';
import 'package:online_shop/widgets/app_drawer.dart';
import 'package:online_shop/widgets/order_list_tile.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  static const routeName = "/OrdersPage";

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProduct>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Umummiy Buyirtmalar"),
      ),
      body: order.orderItems.length > 0
          ? ListView.builder(
              itemCount: order.orderItems.length,
              itemBuilder: (BuildContext context, int index) {
                return OrderListTile(
                  price: order.orderItems[index].price.toString(),
                  time: order.orderItems[index].time,
                  products: order.orderItems[index].products,
                );
              })
          : Center(
              child: Text(
              "Sizda buyurtmalar mavjud emas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            )),
      drawer: AppDrawer(),
    );
  }
}

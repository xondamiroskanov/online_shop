import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/providers/order.dart';
import 'package:online_shop/widgets/app_drawer.dart';
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
      body: ListView.builder(
          itemCount: order.orderItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${order.orderItems[index].price} \$",
              ),
              subtitle: Text(DateFormat("d MM yyy hh:mm")
                  .format(order.orderItems[index].time)
                  .toString()),
            );
          }),
      drawer: AppDrawer(),
    );
  }
}

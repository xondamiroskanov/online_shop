import 'package:flutter/material.dart';
import 'package:online_shop/providers/order.dart';
import 'package:online_shop/widgets/app_drawer.dart';
import 'package:online_shop/widgets/order_list_tile.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  static const routeName = "/OrdersPage";

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future ordersFuture;

  Future<void> getOrdersFuture() {
    return Future.delayed(Duration.zero).then((value) =>
        Provider.of<OrderProduct>(context, listen: false).getOrderProducts());
  }

  @override
  void initState() {
    ordersFuture = getOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Umummiy Buyirtmalar"),
      ),
      body: FutureBuilder(
        future: ordersFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error == null) {
              return Consumer<OrderProduct>(
                builder: (BuildContext context, order, Widget? child) {
                  return order.orderItems.length > 0
                      ? ListView.builder(
                          itemCount: order.orderItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return OrderListTile(
                              price: order.orderItems[index].price,
                              time: order.orderItems[index].time,
                              products: order.orderItems[index].products,
                            );
                          })
                      : const Center(
                          child: Text(
                            "Sizda buyurtmalar mavjud emas",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                        );
                },
              );
            } else {
              return const Center(
                child: Text("Xatolik yuz berdi"),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}

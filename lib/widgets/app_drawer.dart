import 'package:flutter/material.dart';
import 'package:online_shop/pages/home_page.dart';
import 'package:online_shop/pages/manage_product.dart';
import 'package:online_shop/pages/orders_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Kategoriyalar"),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
            },
            child: const ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(Icons.payment),
              title: Text("Buyurtmalar",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
            child: const ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(Icons.production_quantity_limits_sharp),
              title: Text("Mahsulotlar",style: TextStyle(fontWeight: FontWeight.bold),),
            ),

          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(ManageProduct.routeName);
            },
            child: const ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(Icons.settings),
              title: Text("Mahsulotlarni boshqarish",style: TextStyle(fontWeight: FontWeight.bold),),
            ),

          ),
        ],
      ),
    );
  }
}

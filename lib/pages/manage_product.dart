import 'package:flutter/material.dart';
import 'package:online_shop/models/product_model.dart';
import 'package:online_shop/pages/edit_new_product_page.dart';
import 'package:online_shop/providers/products.dart';
import 'package:online_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/manage_product_list.dart';

class ManageProduct extends StatelessWidget {
  ManageProduct({Key? key}) : super(key: key);
  static const routeName = "/manageProduct";
  String title = "Mahsulot qo'shish";
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditNewAddProduct.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
        title: const Text("Mahsulotlarni boshqarish"),
      ),
      body: ListView.builder(
          itemCount: products.productsList.length,
          itemBuilder: (BuildContext context, int index) {
            return ChangeNotifierProvider.value(
              value: products.productsList[index],
              child: ManageProductList(),
            );
          }),
    );
  }
}

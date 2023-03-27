import 'package:flutter/material.dart';
import 'package:online_shop/widgets/custom_shop_icon.dart';
import 'package:online_shop/widgets/product_grid.dart';


enum Filter { All, Favortites }

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(onSelected: (Filter filter) {
              setState(() {
                if (filter == Filter.Favortites) {
                   isFavorite = true;
                } else {
                  isFavorite = false;
                }
              });
            }, itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  child: Text(
                    "Sevimlilar",
                  ),
                  value: Filter.Favortites,
                ),
                PopupMenuItem(
                  child: Text("Barchasi"),
                  value: Filter.All,
                ),
              ];
            }),
            CustomShopIcon()
          ],
          title: Text("My shop"),
        ),
        body: ProductGrid(isFavorite));
  }
}

import 'package:flutter/material.dart';
import 'package:online_shop/pages/home_page.dart';
import 'package:online_shop/pages/product_details.dart';
import 'package:online_shop/providers/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Products>(
      create: (BuildContext context) {
        return Products();
      },
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "HindSiliguri",
          primarySwatch: Colors.teal
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          ProductDetailsPage.routeName : (context)=>ProductDetailsPage()
        },
      ),
    );
  }
}


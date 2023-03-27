import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop/pages/cart_shop_page.dart';
import 'package:online_shop/pages/home_page.dart';
import 'package:online_shop/pages/product_details.dart';
import 'package:online_shop/providers/cart_item.dart';
import 'package:online_shop/providers/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (BuildContext context) {
            return Products();
          },
        ),
        ChangeNotifierProvider<Cart>(create: (BuildContext context) {
          return Cart();
        })
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primarySwatch: Colors.teal),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
          CartShopPage.routeName: (context) => CartShopPage()
        },
      ),
    );
  }
}

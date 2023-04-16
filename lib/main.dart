import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop/pages/auth_page.dart';
import 'package:online_shop/pages/cart_shop_page.dart';
import 'package:online_shop/pages/edit_new_product_page.dart';
import 'package:online_shop/pages/home_page.dart';
import 'package:online_shop/pages/manage_product.dart';
import 'package:online_shop/pages/orders_page.dart';
import 'package:online_shop/pages/product_details.dart';
import 'package:online_shop/providers/cart_item.dart';
import 'package:online_shop/providers/order.dart';
import 'package:online_shop/providers/products.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
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
        }),
        ChangeNotifierProvider<OrderProduct>(create: (BuildContext context){
          return OrderProduct();
        }),
        ChangeNotifierProvider<AuthPro>(create: (BuildContext context){
          return AuthPro();
        })
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primarySwatch: Colors.teal),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          AuthPage.routeName:(context)=>AuthPage(),
          HomePage.routeName:(context)=>HomePage(),
          ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
          CartShopPage.routeName: (context) => CartShopPage(),
          OrdersPage.routeName:(context)=>OrdersPage(),
          ManageProduct.routeName:(context)=>ManageProduct(),
          EditNewAddProduct.routeName:(context)=>EditNewAddProduct()
        },
      ),
    );
  }
}

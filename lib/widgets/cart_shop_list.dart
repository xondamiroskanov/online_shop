import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';
import '../providers/products.dart';

class CartShopList extends StatelessWidget {
  const CartShopList({Key? key}) : super(key: key);

  void dialogDeleteCart(BuildContext context, Function() removeCartProduct) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Savatdan mahsulotni ochirmoqdasiz"),
            content: Text(
                "Savatdan bu mahsulotdagi barcha buyirtmalar o'chirilidai"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("BEKOR QILISH"),
              ),
              TextButton(onPressed: (){
                removeCartProduct();
                Navigator.of(context).pop();
              }, child: Text("O'CHIRISH"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final cartShop = Provider.of<Cart>(context);
    final cartShopMap = cartShop.items;
    final productFavorite = Provider.of<Products>(context);
    return Expanded(
      child: ListView.builder(
          itemCount: cartShopMap.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              key: ValueKey(cartShopMap.keys.toList()[index]),
              endActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    backgroundColor: Theme.of(context).errorColor,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_outline_sharp,
                    label: 'Archive',
                    onPressed: (BuildContext context) {
                      dialogDeleteCart(
                          context,
                          () => cartShop.deleteCartProduct(
                              cartShopMap.keys.toList()[index]),);
                    },
                  ),
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    icon: Icons.favorite_outline,
                    label: 'Archive',
                    onPressed: (BuildContext context) {
                      productFavorite.favorite;
                    },
                  ),
                ],
              ),
              child: Card(
                elevation: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          cartShopMap.values.toList()[index].image),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartShopMap.values.toList()[index].title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Umumiy ${int.parse(cartShopMap.values.toList()[index].price) * cartShopMap.values.toList()[index].number}\$",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            cartShop.minusProduct(
                                cartShop.items.keys.toList()[index]);
                          },
                          child: Text(
                            "-",
                            style:
                                TextStyle(fontSize: 24, color: Colors.black87),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black12),
                          child: Text(cartShopMap.values
                              .toList()[index]
                              .number
                              .toString()),
                        ),
                        TextButton(
                          onPressed: () {
                            cartShop.addToProduct(
                                cartShopMap.values.toList()[index].title,
                                cartShopMap.values.toList()[index].image,
                                cartShopMap.values.toList()[index].price,
                                cartShop.items.keys.toList()[index]);
                          },
                          child: Text("+",
                              style: TextStyle(
                                  fontSize: 24, color: Colors.black87)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

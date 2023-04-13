import 'package:flutter/material.dart';
import 'package:online_shop/pages/edit_new_product_page.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/products.dart';

class ManageProductList extends StatelessWidget {
  ManageProductList({Key? key}) : super(key: key);

  String title = "Mahsulotni tahrirlash";

  void manegeDeleteProduct(BuildContext context, Function() removeCartProduct) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("mahsulotni ochirmoqdasiz"),
            content:
                const Text("Bu mahsulot  butunlay mahsulotlardan o'chiriladi"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("BEKOR QILISH"),
              ),
              TextButton(
                  onPressed: () {
                    removeCartProduct();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "O'CHIRISH",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final sncakMessage = ScaffoldMessenger.of(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(productModel.image),
        ),
        title: Text(productModel.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditNewAddProduct.routeName,
                    arguments: productModel.id);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                manegeDeleteProduct(context, () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .removeProductItem(productModel.id);
                  } catch (error) {
                    sncakMessage.showSnackBar(
                      SnackBar(
                          content: const Text(
                           "Kechirasiz mahsulotni o'chirib bo'lmadi"
                          ),
                          action:
                              SnackBarAction(label: "OK", onPressed: () {})),
                    );
                  }
                });
              },
              icon: Icon(
                Icons.delete_outline_sharp,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

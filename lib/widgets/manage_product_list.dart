import 'package:flutter/material.dart';
import 'package:online_shop/pages/edit_new_product_page.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class ManageProductList extends StatelessWidget {
  ManageProductList({Key? key}) : super(key: key);

  String title = "Mahsulotni tahrirlash";

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
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
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline_sharp,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

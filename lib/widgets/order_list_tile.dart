import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cart_item_model.dart';

class OrderListTile extends StatefulWidget {
  final String price;
  final DateTime time;
  final List<CartItem> products;

  OrderListTile(
      {Key? key,
      required this.price,
      required this.time,
      required this.products})
      : super(key: key);

  @override
  State<OrderListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {
  bool arrow = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "${widget.price} \$",
            ),
            subtitle: Text(
                DateFormat("d/MM/yyy hh:mm").format(widget.time).toString()),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  arrow = !arrow;
                });
              },
              icon: arrow
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_up,
                    ),
            ),
          ),
          if (arrow)
            Container(
              height: 80,
              child: ListView.builder(
                  itemCount: widget.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        widget.products[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      trailing: Text(
                        "${widget.products[index].number} * ${widget.products[index].price}\$",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }),
            )
        ],
      ),
    );
  }
}

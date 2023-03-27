import 'cart_item_model.dart';

class Order{
  final String id;
  final double price;
  final DateTime time;
  final List<CartItem> products;
  Order({
    required this.id,
    required this.price,
    required this.time,
    required this.products
});
}
import 'package:flutter/material.dart';
import 'package:shopping_cart/models/shoes.dart';

class CartListTile extends StatefulWidget {
  final Shoes shoes;
  final Function onTapClick;
  const CartListTile({
    super.key,
    required this.shoes,
    required this.onTapClick,
  });

  @override
  State<CartListTile> createState() => _CartListTileState();
}

class _CartListTileState extends State<CartListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Image.asset(widget.shoes.image, width: 80, height: 80),
        title: Text(widget.shoes.name),
        subtitle: Text(widget.shoes.price),
        trailing: IconButton(
          onPressed: () => widget.onTapClick(),
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_cart/model/products.dart';

class CartTile extends StatelessWidget {
  final ProductModel product;
  final Function()? onDelete;
  const CartTile({super.key, required this.product, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Image.asset(product.image, height: 90),
        title: Text(product.title),
        subtitle: Text('\$${product.price}'),
        trailing: GestureDetector(
          onTap: onDelete,
          child: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}

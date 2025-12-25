import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/component/cart_tile.dart';
import 'package:shopping_cart/model/products.dart';
import 'package:shopping_cart/model/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void deleteFromCart(ProductModel product, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Are you sure you want to delete this from cart?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<ShopModel>().removeFromCart(product);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void payNow(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('User want to pay now!'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listCart = context.watch<ShopModel>().listCart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: listCart.isEmpty
                  ? Center(child: Text('Your cart is empty'))
                  : ListView.builder(
                      itemCount: listCart.length,
                      itemBuilder: (context, index) {
                        return CartTile(
                          product: listCart[index],
                          onDelete: () {
                            deleteFromCart(listCart[index], context);
                          },
                        );
                      },
                    ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ElevatedButton(
              onPressed: () {
                payNow(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text('Pay Now', style: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}

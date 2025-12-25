import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/component/cart_list_tile.dart';
import 'package:shopping_cart/models/cart.dart';
import 'package:shopping_cart/models/shoes.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text(
                "My Cart",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.getCart().length,
                  itemBuilder: (context, index) {
                    Shoes shoes = cart.getCart()[index];
                    return CartListTile(
                      shoes: shoes,
                      onTapClick: () {
                        cart.removeFromCart(shoes);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

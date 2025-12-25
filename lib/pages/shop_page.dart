import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/component/custom_list_tile.dart';
import 'package:shopping_cart/models/cart.dart';
import 'package:shopping_cart/models/shoes.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  void addToCart(Shoes shoes) {
    Provider.of<Cart>(context, listen: false).addToCart(shoes);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Item added to cart'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Search', style: TextStyle(color: Colors.grey)),
                    Icon(Icons.search, color: Colors.grey),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Everyone flies some flies longer than others',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hot picks ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'see all',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.getShoes().length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Shoes shoes = cart.getShoes()[index];
                    return CustomListTile(
                      shoes: shoes,
                      onTapClick: () {
                        addToCart(shoes);
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
                child: Divider(color: Colors.transparent),
              ),
            ],
          ),
        );
      },
    );
  }
}

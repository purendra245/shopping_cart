import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/component/my_drawer.dart';
import 'package:shopping_cart/component/shop_list_tile.dart';
import 'package:shopping_cart/model/shop.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ShopModel>().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Page'),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Pick from selected list of premium products',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 550,
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return ShopListTile(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

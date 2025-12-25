import 'package:flutter/material.dart';
import 'package:shopping_cart/component/list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.shopping_bag,
                  size: 72,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              SizedBox(height: 20),
              MyListTile(
                icon: Icons.home,
                title: 'Shop',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              MyListTile(
                icon: Icons.shopping_cart,
                title: 'Cart',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              title: 'Exit',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/intro',
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

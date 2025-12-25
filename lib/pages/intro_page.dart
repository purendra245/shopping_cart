import 'package:flutter/material.dart';
import 'package:shopping_cart/component/my_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            SizedBox(height: 20),
            Text(
              'Minimal Shop ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Premium Quality Products ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 20),
            MyButton(
              icon: Icons.arrow_forward,
              onTap: () {
                Navigator.pushNamed(context, '/shop');
              },
            ),
          ],
        ),
      ),
    );
  }
}

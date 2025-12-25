import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/component/my_box.dart';
import 'package:shopping_cart/component/my_button.dart';
import 'package:shopping_cart/theme/theme_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: MyBox(
          color: Theme.of(context).colorScheme.primary,
          child: MyButton(
            color: Theme.of(context).colorScheme.secondary,
            onTap: () => {
              debugPrint("Tapped"),
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            },
          ),
        ),
      ),
    );
  }
}

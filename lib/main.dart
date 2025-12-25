import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/model/shop.dart';
import 'package:shopping_cart/pages/cart_page.dart';
import 'package:shopping_cart/pages/intro_page.dart';
import 'package:shopping_cart/pages/shop_page.dart';
import 'package:shopping_cart/theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShopModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: IntroPage(),
      routes: {
        '/intro': (context) => IntroPage(),
        '/shop': (context) => ShopPage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}

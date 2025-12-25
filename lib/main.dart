import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/home_page.dart';
import 'package:shopping_cart/theme/theme_provider.dart';
import 'package:shopping_cart/theme/themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
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
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: HomePage(),
    );  

  }
}

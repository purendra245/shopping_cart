import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:shopping_cart/pages/mobile_page.dart';
import 'package:shopping_cart/pages/responsive.dart';
import 'package:shopping_cart/pages/tablet_page.dart';
import 'package:shopping_cart/pages/webpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
      home: const ResponsiveLayout(
        mobile: MobilePage(),
        tablet: TabletPage(),
        web: WebPage(),
      ),
      routes: {'/home_page': (context) => const HomePage()},
    );
  }
}

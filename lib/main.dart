import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/di/module.dart';
import 'package:shopping_cart/presentation/pages/weather_page.dart';
import 'package:shopping_cart/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_cart/data/database/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Module().init();

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
      home: WeatherPage(),
      routes: {'/home_page': (context) => WeatherPage()},
    );
  }
}

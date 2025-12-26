import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/database/habit_database.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:shopping_cart/themes/theme_provider.dart';

Future<void> main() async {
  //init database
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.init();
  await HabitDatabase().saveFirstLaunchDate();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HabitDatabase(),
        ),
      ],
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
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/pages/auth_page.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:shopping_cart/pages/profle_page.dart';
import 'package:shopping_cart/pages/register_or_login_page.dart';
import 'package:shopping_cart/pages/setting_page.dart';
import 'package:shopping_cart/pages/users_page.dart';
import 'package:shopping_cart/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_cart/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      home: AuthPage(),
      routes: {
        '/login_register_page': (context) => RegisterOrLoginPage(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/setting_page': (context) => SettingPage(),
        '/users_page': (context) => UsersPage(),
      },
    );
  }
}

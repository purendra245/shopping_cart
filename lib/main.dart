import 'package:flutter/material.dart';
import 'package:shopping_cart/firebase_options.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_cart/pages/notification_page.dart';
import 'package:shopping_cart/services/fb_noti_services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FbNotiServices fbNotiServices = FbNotiServices();
  await fbNotiServices.init();
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
      navigatorKey: navigatorKey,
      home: HomePage(),
      routes: {
        '/home_page': (context) => HomePage(),
        '/notification_page': (context) => NotificationPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/home_page.dart';
import 'package:shopping_cart/pages/profile_page.dart';
import 'package:shopping_cart/pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawerExample(),
    );
  }
}

class DrawerExample extends StatelessWidget {
  DrawerExample({super.key});
  final pages = [HomePage(), ProfilePage(), SettingsPage()];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drawer Example")),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[300],
        child: ListView(
          children: [
            DrawerHeader(child: Icon(Icons.person)),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[0]),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Profile"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages[1]),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages[2]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

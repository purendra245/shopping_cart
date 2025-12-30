import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/profle_page.dart';
import 'package:shopping_cart/pages/setting_page.dart';
import 'package:shopping_cart/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logOut() {
    AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Icon(
              Icons.favorite,
              size: 50,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              title: Text(
                "HOME",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              title: Text(
                "PROFILE",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile_page');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(
                Icons.group,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              title: Text(
                "USERS",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/users_page');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/setting_page');
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 30),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              title: Text(
                "LOGOUT",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
              onTap: () {
                logOut();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/register_or_login_page.dart';
import 'package:shopping_cart/pages/users_page.dart';
import 'package:shopping_cart/services/auth_service.dart';
import 'package:shopping_cart/utils/app_utils.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Utils.showSnackBar(context, snapshot.error.toString());
          return const Center(child: Text("Something went wrong"));
        } else if (snapshot.hasData) {
          return UsersPage();
        } else {
          return RegisterOrLoginPage();
        }
      },
    );
  }
}

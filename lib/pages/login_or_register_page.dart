import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/login_page.dart';
import 'package:shopping_cart/pages/sign_up_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool isLogin = true;

  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogin
          ? LoginPage(onTap: toggleView)
          : SignUpPage(onTap: toggleView),
    );
  }
}

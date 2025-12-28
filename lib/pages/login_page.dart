import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/divider_with_text.dart';
import 'package:shopping_cart/components/input_edit_text.dart';
import 'package:shopping_cart/components/my_button.dart';
import 'package:shopping_cart/components/my_loader.dart';
import 'package:shopping_cart/components/square_tile.dart';
import 'package:shopping_cart/pages/login_or_register_page.dart';
import 'package:shopping_cart/pages/sign_up_page.dart';
import 'package:shopping_cart/utils/app_utils.dart';

class LoginPage extends StatelessWidget {
  final Function onTap;
  LoginPage({super.key, required this.onTap});

  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void showError(BuildContext context, String message) {
    debugPrint(message);
    if (!context.mounted) return;
    Utils.showSnackBar(context, message);
  }

  void clearController() {
    _controllerUserName.clear();
    _controllerPassword.clear();
  }

  void onLogin(BuildContext context) async {
    showDialog(context: context, builder: (context) => MyLoader());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerUserName.text,
        password: _controllerPassword.text,
      );
      clearController();
    } on FirebaseAuthException catch (e) {
      clearController();
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        showError(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showError(context, "Wrong password provided for that user.");
      } else {
        showError(context, e.message ?? "An error occurred.");
      }
    } catch (e) {
      clearController();
      showError(context, e.toString());
    }
    Navigator.pop(context);
  }

  void onRegister() {
    onTap();
  }

  void onForgotPassword() {
    debugPrint("Forgot Password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 80),
                SizedBox(height: 20),
                Text(
                  "Welcome Back you have been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 30),
                InputEditTextField(
                  controller: _controllerUserName,
                  hintText: "User Name",
                  obsecureText: false,
                ),
                InputEditTextField(
                  controller: _controllerPassword,
                  hintText: "Password",
                  obsecureText: true,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onForgotPassword();
                        },

                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  text: "Login",
                  onTap: () {
                    onLogin(context);
                  },
                ),
                SizedBox(height: 50),
                DividerWithText(text: "Or continue with"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "lib/images/logo-google-icon.png"),
                    SizedBox(width: 25),
                    SquareTile(imagePath: "lib/images/apple-icon-white.jpg"),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        onRegister();
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

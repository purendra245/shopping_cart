import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/divider_with_text.dart';
import 'package:shopping_cart/components/input_edit_text.dart';
import 'package:shopping_cart/components/my_button.dart';
import 'package:shopping_cart/components/my_loader.dart';
import 'package:shopping_cart/components/square_tile.dart';
import 'package:shopping_cart/pages/login_page.dart';
import 'package:shopping_cart/utils/app_utils.dart';

class SignUpPage extends StatelessWidget {
  final Function onTap;
  SignUpPage({super.key, required this.onTap});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void showError(BuildContext context, String message) {
    debugPrint(message);
    if (!context.mounted) return;
    Utils.showSnackBar(context, message);
  }

  Future<void> onSignUp(BuildContext context) async {
    if (_userNameController.text.isEmpty &&
        _passwordController.text.isEmpty &&
        _confirmPasswordController.text.isEmpty) {
      showError(context, "Please fill all the fields");
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      showError(context, "Passwords do not match");
      return;
    }
    showDialog(context: context, builder: (context) => MyLoader());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _userNameController.text,
        password: _passwordController.text,
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

  void onForgotPassword() {}

  void onLogin() {
    onTap();
  }

  void clearController() {
    _userNameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.lock, size: 80),
                SizedBox(height: 20),
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 20),
                InputEditTextField(
                  hintText: "User Name",
                  obsecureText: false,
                  controller: _userNameController,
                ),
                InputEditTextField(
                  hintText: "Password",
                  obsecureText: true,
                  controller: _passwordController,
                ),
                InputEditTextField(
                  hintText: "Confirm Password",
                  obsecureText: true,
                  controller: _confirmPasswordController,
                ),
                SizedBox(height: 50),
                MyButton(
                  text: "Sign Up",
                  onTap: () {
                    onSignUp(context);
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
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        onLogin();
                      },
                      child: Text(
                        "Login now",
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

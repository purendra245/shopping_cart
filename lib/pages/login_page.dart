import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_button.dart';
import 'package:shopping_cart/components/my_text_filed.dart';
import 'package:shopping_cart/services/auth_service.dart';
import 'package:shopping_cart/utils/app_utils.dart';

class LoginPage extends StatelessWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgotPasswordController =
      TextEditingController();

  Future<void> forgotPassword(BuildContext context, String email) async {
    if (!context.mounted) return;
    showLoader(context);
    try {
      await AuthService().forgotPassword(email);
    } catch (e) {
      if (!context.mounted) return;
      Utils.showSnackBar(context, e.toString());
    }
    if (!context.mounted) return;
    Navigator.pop(context);
    return;
  }

  void forgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password'),
        content: TextField(
          controller: _forgotPasswordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: 'Enter your email',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              forgotPassword(context, _forgotPasswordController.text);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showLoader(BuildContext context) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => Center(child: const CircularProgressIndicator()),
    );
  }

  Future<UserCredential?> loginNow(
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    showLoader(context);
    try {
      await AuthService().signWithEmailPassword(emailAddress, password);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return null;
      if (e.code == 'user-not-found') {
        Utils.showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.showSnackBar(context, 'Wrong password provided for that user.');
      }
    }
    if (!context.mounted) return null;
    Navigator.pop(context);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 30),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 25),
                MyTextFiled(
                  hintText: 'Email',
                  obsecureText: false,
                  controller: _emailController,
                ),
                MyTextFiled(
                  hintText: 'Password',
                  obsecureText: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        forgotPasswordDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyButton(
                  onPressed: () {
                    loginNow(
                      _emailController.text,
                      _passwordController.text,
                      context,
                    );
                  },
                  text: 'Login',
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onTertiary,
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

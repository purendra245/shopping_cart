import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_button.dart';
import 'package:shopping_cart/components/my_text_filed.dart';
import 'package:shopping_cart/services/auth_service.dart';
import 'package:shopping_cart/services/user_service.dart';
import 'package:shopping_cart/utils/app_utils.dart';

class RegisterPage extends StatelessWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Future<UserCredential?> signUp(
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      Utils.showSnackBar(context, "Passwords don't match!");
      return null; // Stop the function here
    }

    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      UserCredential? userCredential = await AuthService()
          .signUpWithEmailPassword(emailAddress, password);
      UserService().createUserCredentials(
        userCredential: userCredential,
        userName: _usernameController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return null;
      if (e.code == 'weak-password') {
        Utils.showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar(
          context,
          'The account already exists for that email.',
        );
      } else {
        Utils.showSnackBar(context, e.toString());
      }
    } catch (e) {
      if (!context.mounted) return null;
      Utils.showSnackBar(context, e.toString());
    }
    if (context.mounted) Navigator.pop(context);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                SizedBox(height: 20),
                Text(
                  'M I N I M A L',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 25),
                MyTextFiled(
                  hintText: 'Username',
                  obsecureText: false,
                  controller: _usernameController,
                ),
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
                MyTextFiled(
                  hintText: 'Confirm Password',
                  obsecureText: true,
                  controller: _confirmPasswordController,
                ),
                SizedBox(height: 25),
                MyButton(
                  onPressed: () {
                    signUp(
                      _emailController.text,
                      _passwordController.text,
                      context,
                    );
                  },
                  text: 'Sign Up',
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an member?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Login now',
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

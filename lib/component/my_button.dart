import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.yellow),
        ),
        child: Text(buttonTitle),
      ),
    );
  }
}

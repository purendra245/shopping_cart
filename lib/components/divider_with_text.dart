import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
          Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
        ],
      ),
    );
  }
}

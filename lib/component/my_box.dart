import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final Color color;
  final Widget? child;
  const MyBox({super.key, required this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}

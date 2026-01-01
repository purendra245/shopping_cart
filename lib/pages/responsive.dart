import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.web,
  });
  final Widget mobile;
  final Widget tablet;
  final Widget web;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        if (constrain.maxWidth < 500) {
          return mobile;
        } else if (constrain.maxWidth < 1100) {
          return tablet;
        } else {
          return web;
        }
      },
    );
  }
}

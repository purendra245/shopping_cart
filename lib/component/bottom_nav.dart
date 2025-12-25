import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  final Function(int)? tabChanged;
  const BottomNav({super.key, this.tabChanged});

  @override
  Widget build(BuildContext context) {
    return GNav(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.grey[400],
      activeColor: Colors.grey.shade700,
      tabBackgroundColor: Colors.grey.shade100,
      tabActiveBorder: Border.all(color: Colors.white),
      mainAxisAlignment: MainAxisAlignment.center,
      tabBorderRadius: 16,
      gap: 8,
      onTabChange: tabChanged,
      tabs: [
        GButton(icon: Icons.home, text: 'Shop'),
        GButton(icon: Icons.shopping_cart, text: 'Cart'),
      ],
    );
  }
}

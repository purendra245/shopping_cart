import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_list_tile.dart';
import 'package:shopping_cart/services/auth_service.dart';
import 'package:shopping_cart/services/user_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.secondary),
      // Use a single Column as the body
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: UserService().getUserDetails(user),
        builder:
            (
              BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                Map<String, dynamic>? userData = snapshot.data!.data();
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${userData!['username']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${userData['email']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // This Expanded now correctly takes up the remaining screen height
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return MyListTile(
                            title: "Item $index",
                            subtitle: "Item $index",
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text("No Data"));
            },
      ),
    );
  }
}

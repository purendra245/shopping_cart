import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/components/my_drawer.dart';
import 'package:shopping_cart/components/my_list_tile.dart';
import 'package:shopping_cart/components/my_rounded_button.dart';
import 'package:shopping_cart/components/my_text_filed.dart';
import 'package:shopping_cart/services/post_service.dart';
import 'package:shopping_cart/utils/app_utils.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _postController = TextEditingController();

  void postMessage(BuildContext context) {
    if (_postController.text.isNotEmpty) {
      PostService().addPost(_postController.text);
    } else {
      Utils.showSnackBar(context, "Please enter a post");
    }
    _postController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "W A L L",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyTextFiled(
                      hintText: 'Say something..',
                      obsecureText: false,
                      controller: _postController,
                    ),
                  ),
                  MyRoundedButton(
                    onTap: () {
                      postMessage(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: PostService().getPostsStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    final posts = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return MyListTile(
                          title: post['PostMessage'],
                          subtitle:
                              post['UserEmail'] +
                              " " +
                              post['Timestamp'].toDate().toString(),
                        );
                      },
                    );
                  }
                  return const Center(child: Text("No posts available"));
                },
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

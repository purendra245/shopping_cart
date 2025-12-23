import 'package:flutter/material.dart';
import 'package:shopping_cart/component/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SizedBox(
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add new Task",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(buttonTitle: "Save", onPressed: onSave),
                    SizedBox(width: 10),
                    MyButton(buttonTitle: "Cancel", onPressed: onCancel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

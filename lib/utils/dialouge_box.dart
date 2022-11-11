import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/my_botton.dart';

class dialougebox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  dialougebox({
    required this.controller,
    required this.onSave,
    required this.onCancel,
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade600,
      content: Container(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add the task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  MyButton(text: "Save", onPressed: onSave),
                SizedBox(width: 10),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

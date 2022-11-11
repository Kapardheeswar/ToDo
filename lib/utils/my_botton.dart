import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  MyButton({
    required this.text,
    required this.onPressed,
});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed,
    color: Colors.yellowAccent,
    child: Text(text),
    );
  }
}

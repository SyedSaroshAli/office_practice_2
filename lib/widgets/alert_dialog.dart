import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title, content, buttonText;
  BuildContext context1;
   AlertDialogWidget({super.key, required this.title, required this.content, required this.buttonText, required this.context1});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
       GestureDetector(
        onTap: () {
          Navigator.pop(context1);
        },
        child: Text(buttonText),)
      ],
    );
  }
}
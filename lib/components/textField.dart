import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final  TextEditingController controller;
  final String label;
  final String hintText;
  
  const TextFieldComponent({super.key,required this.controller,required this.label, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: hintText,
                label: Text(label),
                labelStyle: TextStyle(color: Colors.grey.shade200),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300
                  )
                ),            
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100
                  )
                )
              ),
            );
  }
}
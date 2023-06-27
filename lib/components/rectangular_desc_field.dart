import 'package:flutter/material.dart';

import '../constant.dart';
import 'neumorphic_text_field_container.dart';
import 'neumorphic_text_field_desc_container.dart';

class RectangularDescField extends StatelessWidget {

  final String hintText;
  // final IconData icon;
  final bool obscureText;
  final controller;

  const RectangularDescField({Key? key, required this.hintText, required this.obscureText, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DescTextFieldContainer(
        child: Padding(
          padding: const EdgeInsets.only(top: 4,right: 16,left: 16),
          child: TextField(
            controller: controller,
            cursorColor: black,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              helperStyle: TextStyle(
                color: black.withOpacity(0.7),
                fontSize: 18,
              ),
              // prefixIcon: Icon(icon,color: black.withOpacity(0.7),size: 20,),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

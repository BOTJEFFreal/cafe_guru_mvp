import 'package:flutter/material.dart';

import '../constant.dart';


class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final double fontSize;

  const RectangularButton({Key? key, required this.text, required this.press, required this.fontSize})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(top: appPadding,bottom: appPadding /2),
        child: Container(
          // width: width,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    darkPrimary,
                    lightPrimary,
                  ]
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]
          ),
          child: Center(
            child: Text(text,style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
            ),),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/sizes.dart';

Widget button(
    {required context,
    String? text,
    Widget? child,
    textColor = whiteColor,
    btnColor = blueElementColor,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: screenWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      decoration: BoxDecoration(
          color: Color(btnColor),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: text != null && child == null
          ? elementRegluar(
              text: text,
              textAlign: TextAlign.center,
              color: textColor,
              context: context)
          : child,
    ),
  );
}

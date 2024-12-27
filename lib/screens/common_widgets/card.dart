import 'package:flutter/material.dart';
import 'package:haajaree/constants/colors.dart';

Widget card(
    {required context,
    required Widget child,
    double? width,
    double? height,
    BorderRadiusGeometry? radius,
    AlignmentGeometry? alignment,
    EdgeInsets? margin,
    EdgeInsets? padding,
    DecorationImage? image,
    cardColor = whiteColor}) {
  radius ??= BorderRadius.circular(10);
  // width ??= screenWidth(context);
  return Container(
    width: width,
    height: height,
    padding: padding,
    margin: margin,
    alignment: alignment,
    decoration: BoxDecoration(
        color: Color(cardColor),
        borderRadius: radius,
        image: image,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]),
    child: child,
  );
}

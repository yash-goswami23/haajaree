import 'package:flutter/material.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/screens/common_widgets/card.dart';

Widget homeMiniCard(
    {required Widget child,
    VoidCallback? onTap,
    cardColor = whiteColor,
    required context}) {
  return GestureDetector(
    onTap: onTap,
    child: card(
        context: context,
        cardColor: cardColor,
        height: 35, //screenHeight(context, dividedBy: 22), //35,
        width: 35, //screenWidth(context, dividedBy: 10.5), //35,
        radius: BorderRadius.circular(8),
        alignment: Alignment.center,
        child: child),
  );
}

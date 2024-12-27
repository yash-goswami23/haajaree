import 'package:flutter/material.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/screens/common_widgets/card.dart';

Widget progressItem(
    {required context,
    required String title,
    required String value,
    required bool isRight}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      card(
        context: context,
        alignment: Alignment.center,
        width: isRight
            ? screenWidth(context, dividedBy: 1.5)
            : screenWidth(context, dividedBy: 4.5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        radius: const BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        child: titleMedium(
            text: isRight ? title : value,
            color: bgColor,
            fontsSize: 32,
            context: context),
      ),
      card(
          context: context,
          alignment: Alignment.center,
          width: isRight
              ? screenWidth(context, dividedBy: 4.5)
              : screenWidth(context, dividedBy: 1.5),
          radius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: titleMedium(
              text: isRight ? value : title,
              color: bgColor,
              fontsSize: 32,
              context: context))
    ],
  );
}

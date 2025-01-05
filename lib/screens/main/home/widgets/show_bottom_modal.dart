import 'package:flutter/material.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/screens/common_widgets/card.dart';

showBottomModalDialog({
  required BuildContext context,
  required Widget child,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the sheet full height if needed
      barrierColor: Colors.black38, // Background fade-out effect
      builder: (BuildContext modalContext) => card(
          context: context,
          height: screenHeight(context, dividedBy: 2),
          cardColor: whiteColor,
          radius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          child: Material(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25.0)),
              color: const Color(whiteColor),
              child: child)));
}

Widget bottomSheetItemCard({
  required context,
  required String text,
  required int selectedIndex,
  required int index,
  required String hour,
  Widget? hourItem,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(whiteColor), Color(bgColor)])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          elementRegluar(text: text, color: bgColor, context: context),
          Row(
            children: [
              if (hourItem != null) hourItem,
              card(
                  context: context,
                  cardColor: selectedIndex == index ? greenColor : whiteColor,
                  child: Container(),
                  height: 35,
                  width: 35,
                  radius: BorderRadius.circular(50)),
            ],
          )
        ],
      ),
    ),
  );
}

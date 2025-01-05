import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';

showToast(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(whiteColor),
      textColor: const Color(bgColor),
      fontSize: 14.0);
}

showSnakBar(context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: inputBold(text: msg, color: redColor, context: context),
      backgroundColor: const Color(whiteColor),
    ),
  );
}

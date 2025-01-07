import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/utils/text_size_fix.dart';

//Urbanist regluar
Widget elementRegluar({
  required String text,
  color = whiteColor,
  TextAlign? textAlign,
  fontSized = 20.0,
  required BuildContext context,
}) =>
    Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.urbanist(
          fontSize: fontSized,
          fontWeight: FontWeight.w400,
          color: Color(color)),
      textScaleFactor: ScaleSize.textScaleFactor(context),
    );

//Urbanist bold
Widget headingBlod(
        {required String text,
        color = whiteColor,
        TextAlign? textAlign,
        required BuildContext context}) =>
    Text(text,
        textAlign: textAlign,
        style: GoogleFonts.urbanist(
            fontSize: 40, fontWeight: FontWeight.w600, color: Color(color)),
        textScaleFactor: ScaleSize.textScaleFactor(context));

//Urbanist title medium
Widget titleMedium(
        {required String text,
        color = whiteColor,
        TextAlign? textAlign,
        double fontsSize = 38,
        required BuildContext context}) =>
    Text(text,
        textAlign: textAlign,
        style: GoogleFonts.urbanist(
            fontSize: fontsSize,
            fontWeight: FontWeight.w500,
            color: Color(color)),
        textScaleFactor: ScaleSize.textScaleFactor(context));

//Urbanist heading small
Widget headingSmall(
        {required String text,
        color = whiteColor,
        TextAlign? textAlign,
        required BuildContext context}) =>
    Text(text,
        textAlign: textAlign,
        style: GoogleFonts.urbanist(
            fontSize: 24, fontWeight: FontWeight.w600, color: Color(color)),
        textScaleFactor: ScaleSize.textScaleFactor(context));

//Urbanist lebal Small
Widget lebalSmall(
        {required String text,
        color = whiteColor,
        TextAlign? textAlign,
        required BuildContext context}) =>
    Text(text,
        textAlign: textAlign,
        style: GoogleFonts.urbanist(
            fontSize: 13, fontWeight: FontWeight.w300, color: Color(color)),
        textScaleFactor: ScaleSize.textScaleFactor(context));

//Urbanist input bold
Widget inputBold(
        {required String text,
        color = whiteColor,
        TextAlign? textAlign,
        required BuildContext context}) =>
    Text(text,
        textAlign: textAlign,
        style: GoogleFonts.urbanist(
            fontSize: 16, fontWeight: FontWeight.w600, color: Color(color)),
        textScaleFactor: ScaleSize.textScaleFactor(context));

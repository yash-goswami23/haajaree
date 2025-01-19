import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haajaree/constants/colors.dart';

Widget customTextField(
    {required TextEditingController controller,
    required String label,
    Widget? suffixWidget,
    bool obscureText = false,
    bool enabled = true,
    TextInputType? textInputType,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator}) {
  return Container(
    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 15),
    decoration: BoxDecoration(
      // color: Color(bgColor),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(bgColor)),
    ),
    child: TextFormField(
      enabled: enabled,
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.urbanist(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(blackColor),
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(
              color: Color(blackColor),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          suffixIcon: suffixWidget),
      validator: validator,
      onChanged: onChanged,
    ),
  );
}

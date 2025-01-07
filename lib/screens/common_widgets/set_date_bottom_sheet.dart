import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:intl/intl.dart';

void _showDialog(Widget child, BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}

Widget dateTimeContainer(
    {required DateTime date,
    bool isChlickable = true,
    required ValueChanged<DateTime> onDateChange,
    required BuildContext context}) {
  // final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
  // final hour12Format = DateFormat('hh a').format(moonLanding.toLocal());
  return GestureDetector(
    // Display a CupertinoDatePicker in date picker mode.
    onTap: () => isChlickable
        ? _showDialog(
            CupertinoDatePicker(
              // initialDateTime: date,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: false,
              // maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
            context)
        : null,
    child: AnimatedContainer(
      decoration: BoxDecoration(
        color: const Color(whiteColor),
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(7),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      duration: const Duration(seconds: 1),
      child: inputBold(
          text:
              '${DateFormat('hh').format(date.toLocal())}-${DateFormat('mm').format(date.toLocal())}',
          color: blueElementColor,
          context: context
          // fontSzie: 14,
          // fontWeight: FontWeight.
          ),
    ),
  );
}

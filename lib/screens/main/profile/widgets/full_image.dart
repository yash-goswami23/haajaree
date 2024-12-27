import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:haajaree/screens/common_widgets/card.dart';

showImage(BuildContext context, File img) {
  return showDialog(
      context: context,
      // barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Dialog(
              insetAnimationDuration: const Duration(seconds: 5),
              insetAnimationCurve: Curves.decelerate,
              child: card(
                context: context,
                // height: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Hero(
                    tag: 'imageHero',
                    child: Image.file(img),
                  ),
                ),
              ),
            ),
          ));
}

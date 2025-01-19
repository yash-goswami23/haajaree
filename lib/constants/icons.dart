// icons
import 'package:flutter/material.dart';
import 'package:haajaree/constants/colors.dart';

const checked = "assets/icons/checked.svg";
const clossIcon = "assets/icons/clossIcon.svg";
const nonChecked = "assets/icons/nonChecked.svg";
const openIcon = "assets/icons/openIcon.svg";
const gmail = "assets/icons/Gmail.svg";
const camera = "assets/icons/camera.svg";
const gallery = "assets/icons/gallery.svg";

//bottom navi bar
const home = 'assets/icons/home.svg';
const fillHome = 'assets/icons/fillHome.svg';
const progress = 'assets/icons/progress.svg';
const fillProgress = 'assets/icons/fillprogress.svg';
const profile = 'assets/icons/profile.svg';
const fillProfile = 'assets/icons/fillProfile.svg';

//images
const logo = 'assets/images/logos.png';
Widget appLogo({double width = 100, double height = 135, color = bgColor}) =>
    Image.asset(
      logo,
      width: width,
      height: height,
      color: Color(color),
    );

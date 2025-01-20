import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/icons.dart';
import 'package:haajaree/screens/main/home/home.dart';
import 'package:haajaree/screens/main/profile/profile.dart';
import 'package:haajaree/screens/main/progress/progress.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int index = 0;
  final screens = [
    const Home(),
    const Progress(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        bottomNavigationBar: BottomNavigationBarTheme(
          data: const BottomNavigationBarThemeData(
              backgroundColor: Color(blueElementColor),
              selectedItemColor: Color(whiteColor),
              unselectedItemColor: Color(whiteColor),
              elevation: 5,
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'urbanist',
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: Color(whiteColor),
                  height: 1.8),
              selectedLabelStyle: TextStyle(
                  fontFamily: 'urbanist',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(whiteColor),
                  height: 1.8),
              selectedIconTheme: IconThemeData(size: 40),
              unselectedIconTheme: IconThemeData(size: 36)),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(blueElementColor),
                border:
                    Border(top: BorderSide(color: Colors.black12, width: 0.5))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              currentIndex: index,
              onTap: (int newIndex) {
                setState(() {
                  index = newIndex;
                });
              },
              items: [
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      fillHome,
                      height: 35,
                      width: 35,
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      home,
                      height: 30,
                      width: 30,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      fillProgress,
                      height: 35,
                      width: 35,
                      // color: const Color(0xff1D1B20),
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      progress,
                      height: 30,
                      width: 30,
                      // color: Colors.grey,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'Total Progress'),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      fillProfile,
                      height: 35,
                      width: 35,
                      // color: const Color(0xff1D1B20),
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      profile,
                      height: 30,
                      width: 30,
                      // color: Colors.grey,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'Profile'),
              ],
            ),
          ),
        ));
  }
}

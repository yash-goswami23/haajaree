import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/screens/common_widgets/card.dart';
import 'package:haajaree/screens/main/home/widgets/show_bottom_modal.dart';
import 'package:haajaree/utils/show_taost.dart';
import 'package:numberpicker/numberpicker.dart';

class PresentItems extends StatefulWidget {
  final Function(String, int)? onTap;
  const PresentItems({super.key, this.onTap});

  @override
  State<PresentItems> createState() => _PresentItemsState();
}

class _PresentItemsState extends State<PresentItems> {
  int selectedIndex = 0;
  int currentValue1 = 0;
  int currentValue2 = 0;
  String selectedItem = ''; // P,P+OT,OT

  @override
  void initState() {
    super.initState();
    // selectedIndex = widget.selectedValue;
    // print(
    //     'selectedIndex $selectedIndex, selectedValue: ${widget.selectedValue}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomSheetItemCard(
              context: context,
              // showHour: false,
              index: 1,
              text: 'Full Duty No Over-Time',
              selectedIndex: selectedIndex,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                selectedItem = 'P';
                if (widget.onTap != null) {
                  widget.onTap!(selectedItem, 0);
                }
                Navigator.pop(context);
              },
              hour: '0'),
          bottomSheetItemCard(
              context: context,
              // showHour: true,
              index: 2,
              selectedIndex: selectedIndex,
              text: 'Full Duty With Over-Time',
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                if (currentValue1 != 0) {
                  selectedItem = 'POT';
                  if (widget.onTap != null) {
                    widget.onTap!(selectedItem, currentValue1);
                  }
                  Navigator.pop(context);
                } else {
                  showToast('Enter The How Much Over-Time You Work.');
                }
              },
              hourItem: Stack(
                alignment: Alignment.center,
                children: [
                  card(
                    context: context,
                    // margin: const EdgeInsets.only(right: 8),
                    height: 35,
                    width: 35,
                    child: Container(),
                  ),
                  NumberPicker(
                    value: currentValue1,
                    minValue: 0,
                    axis: Axis.horizontal,
                    maxValue: 10,
                    // infiniteLoop: true,
                    itemWidth: 35,
                    itemHeight: 35,
                    itemCount: 3,
                    haptics: true,
                    textStyle: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color(blackColor)),
                    selectedTextStyle: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color(bgColor)),
                    onChanged: (value) => setState(() => currentValue1 = value),
                  ),
                ],
              ),
              hour: currentValue1.toString()),
          bottomSheetItemCard(
              context: context,
              // showHour: true,
              index: 3,
              selectedIndex: selectedIndex,
              text: 'Only-Time',
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                if (currentValue2 != 0) {
                  selectedItem = 'OT';
                  if (widget.onTap != null) {
                    widget.onTap!(selectedItem, currentValue2);
                  }
                  Navigator.pop(context);
                } else {
                  showToast('Enter The How Much Over-Time You Work.');
                }
              },
              hourItem: Stack(
                alignment: Alignment.center,
                children: [
                  card(
                    context: context,
                    // margin: const EdgeInsets.only(right: 8),
                    height: 35,
                    width: 35,
                    child: Container(),
                  ),
                  NumberPicker(
                    value: currentValue2,
                    minValue: 0,
                    axis: Axis.horizontal,
                    maxValue: 10,
                    // infiniteLoop: true,
                    itemWidth: 35,
                    itemHeight: 35,
                    itemCount: 3,
                    haptics: true,
                    textStyle: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color(blackColor)),
                    selectedTextStyle: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color(bgColor)),
                    onChanged: (value) => setState(() => currentValue2 = value),
                  ),
                ],
              ),
              hour: currentValue1.toString()),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/icons.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/models/home_model.dart';
import 'package:haajaree/screens/common_widgets/card.dart';
import 'package:haajaree/screens/main/home/widgets/home_mini_card.dart';
import 'package:haajaree/screens/main/home/widgets/present_item.dart';
import 'package:haajaree/screens/main/home/widgets/show_bottom_modal.dart';

class HomeMainCard extends StatefulWidget {
  final BuildContext context;
  final String date;
  final String day;
  final String seletedValue;
  final String hour;
  final Function(HomeModel)? saveBtn;
  // final bool isCheck;
  final bool isRight;
  const HomeMainCard(
      {super.key,
      required this.context,
      required this.date,
      required this.seletedValue,
      required this.day,
      this.saveBtn,
      this.hour = '0',
      // this.isCheck = false,
      required this.isRight});

  @override
  State<HomeMainCard> createState() => HomeMainCardState();
}

class HomeMainCardState extends State<HomeMainCard> {
  dynamic pColor = whiteColor;
  dynamic aColor = whiteColor;
  dynamic hColor = whiteColor;
  String currentValue = '';
  String pChanges = 'P';
  String overTime = '0';
  @override
  void initState() {
    super.initState();
    overTime = widget.hour;
    if (widget.seletedValue.isNotEmpty) {
      currentValue = widget.seletedValue;
      if (widget.seletedValue == 'P' ||
          widget.seletedValue == 'POT' ||
          widget.seletedValue == 'OT') {
        pChanges = widget.seletedValue;
      }
      overTime = widget.hour;
      changeColor(currentValue);
    }
  }

  changeColor(String value) {
    if (value == 'P' || value == 'POT' || value == 'OT') {
      pColor = greenColor;
      aColor = whiteColor;
      hColor = whiteColor;
      // currentValue = 'P';
    } else if (value == 'H') {
      pColor = whiteColor;
      aColor = whiteColor;
      hColor = greyColor;
      currentValue = 'H';
    } else {
      pColor = whiteColor;
      aColor = redColor;
      hColor = whiteColor;
      currentValue = 'A';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isClickable = widget.seletedValue.isEmpty;
    return Row(
      mainAxisAlignment:
          widget.isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        card(
            context: context,
            width: screenWidth(context, dividedBy: 1.15),
            radius: widget.isRight
                ? const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18))
                : const BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: widget.isRight
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                card(
                  context: context,
                  width: screenWidth(context, dividedBy: 1.4),
                  child: elementRegluar(
                      text: "${widget.date} ${widget.day}", context: context),
                  cardColor: bgColor,
                  alignment: widget.isRight
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  padding: widget.isRight
                      ? const EdgeInsets.only(left: 15, top: 5, bottom: 5)
                      : const EdgeInsets.only(right: 15, top: 5, bottom: 5),
                  radius: widget.isRight
                      ? const BorderRadius.only(bottomLeft: Radius.circular(12))
                      : const BorderRadius.only(
                          bottomRight: Radius.circular(12)),
                ),
                const SizedBox(height: 15),
                card(
                  context: context,
                  width: screenWidth(context, dividedBy: 1.4),
                  cardColor: bgColor,
                  alignment: widget.isRight
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  padding: widget.isRight
                      ? const EdgeInsets.only(left: 15)
                      : const EdgeInsets.only(right: 15),
                  radius: widget.isRight
                      ? const BorderRadius.only(topLeft: Radius.circular(12))
                      : const BorderRadius.only(topRight: Radius.circular(12)),
                  child: Padding(
                    padding: widget.isRight
                        ? const EdgeInsets.only(
                            left: 4, top: 6, bottom: 6, right: 14)
                        : const EdgeInsets.only(
                            right: 4, top: 6, bottom: 6, left: 14),
                    child: Row(
                      mainAxisAlignment: widget.isRight
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: widget.isRight
                          ? [
                              Row(children: [
                                homeMiniCard(
                                    cardColor: pColor,
                                    onTap: () {
                                      // bsSelectedValue = 2;
                                      if (isClickable) {
                                        // setState(() {
                                        //   changeColor("P");
                                        // });
                                        showBottomModalDialog(
                                          context: context,
                                          child: PresentItems(
                                              onTap: (selectedItem, hour) {
                                            pChanges = selectedItem;
                                            currentValue = selectedItem;
                                            overTime = hour.toString();
                                            setState(() {
                                              changeColor("P");
                                            });
                                          }),
                                        );
                                      }
                                    },
                                    child: elementRegluar(
                                        text: pChanges,
                                        color: bgColor,
                                        fontSized:
                                            pChanges == 'POT' ? 18.0 : 20.0,
                                        context: context),
                                    context: context),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: homeMiniCard(
                                      cardColor: aColor,
                                      onTap: () {
                                        if (isClickable) {
                                          setState(() {
                                            changeColor("A");
                                          });
                                        }
                                      },
                                      child: elementRegluar(
                                          text: 'A',
                                          color: bgColor,
                                          context: context),
                                      context: context),
                                ),
                                homeMiniCard(
                                    onTap: () {
                                      if (isClickable) {
                                        setState(() {
                                          changeColor("H");
                                        });
                                      }
                                    },
                                    cardColor: hColor,
                                    child: elementRegluar(
                                        text: 'H',
                                        color: bgColor,
                                        context: context),
                                    context: context),
                                SizedBox(
                                    width: screenWidth(context, dividedBy: 18)),
                                if (currentValue == pChanges)
                                  homeMiniCard(
                                      child: elementRegluar(
                                          text: overTime,
                                          color: bgColor,
                                          context: context),
                                      context: context),
                                SizedBox(
                                    width: screenWidth(context, dividedBy: 25)),
                                if (widget.seletedValue.isEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      final saveModel = HomeModel(
                                          dutyStatus: currentValue,
                                          day: widget.day,
                                          date: widget.date,
                                          overTime: overTime);
                                      if (widget.saveBtn != null) {
                                        widget.saveBtn!(saveModel);
                                      }
                                    },
                                    child: homeMiniCard(
                                        child: currentValue.isEmpty
                                            ? SvgPicture.asset(nonChecked)
                                            : SvgPicture.asset(checked),
                                        context: context),
                                  ),
                              ])
                            ]
                          : [
                              if (widget.seletedValue.isEmpty)
                                GestureDetector(
                                  onTap: () {
                                    final saveModel = HomeModel(
                                        dutyStatus: currentValue,
                                        day: widget.day,
                                        date: widget.date,
                                        overTime: overTime);
                                    if (widget.saveBtn != null) {
                                      widget.saveBtn!(saveModel);
                                    }
                                  },
                                  child: homeMiniCard(
                                      child: currentValue.isEmpty
                                          ? SvgPicture.asset(nonChecked)
                                          : SvgPicture.asset(checked),
                                      context: context),
                                ),
                              SizedBox(
                                  width: screenWidth(context, dividedBy: 25)),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.max,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (currentValue == pChanges)
                                    homeMiniCard(
                                        child: elementRegluar(
                                            text: overTime,
                                            color: bgColor,
                                            context: context),
                                        context: context),
                                  SizedBox(
                                      width:
                                          screenWidth(context, dividedBy: 18)),
                                  Row(
                                    children: [
                                      homeMiniCard(
                                          onTap: () {
                                            if (isClickable) {
                                              setState(() {
                                                changeColor("H");
                                              });
                                            }
                                          },
                                          cardColor: hColor,
                                          child: elementRegluar(
                                              text: 'H',
                                              color: bgColor,
                                              context: context),
                                          context: context),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: homeMiniCard(
                                            cardColor: aColor,
                                            onTap: () {
                                              if (isClickable) {
                                                setState(() {
                                                  changeColor("A");
                                                });
                                              }
                                            },
                                            child: elementRegluar(
                                                text: 'A',
                                                color: bgColor,
                                                context: context),
                                            context: context),
                                      ),
                                      homeMiniCard(
                                          cardColor: pColor,
                                          onTap: () {
                                            if (isClickable) {
                                              // setState(() {
                                              //   changeColor("P");
                                              // });
                                              showBottomModalDialog(
                                                context: context,
                                                child: PresentItems(onTap:
                                                    (selectedItem, hour) {
                                                  pChanges = selectedItem;
                                                  currentValue = selectedItem;
                                                  overTime = hour.toString();
                                                  setState(() {
                                                    changeColor("P");
                                                  });
                                                }),
                                              );
                                            }
                                          },
                                          child: elementRegluar(
                                              text: pChanges,
                                              color: bgColor,
                                              fontSized: pChanges == 'POT'
                                                  ? 18.0
                                                  : 20.0,
                                              context: context),
                                          context: context),
                                    ],
                                  )
                                ],
                              ),
                            ],
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}

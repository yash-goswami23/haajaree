import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haajaree/bloc/auth_bloc/auth_bloc.dart';
import 'package:haajaree/bloc/user_bloc/user_bloc.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/icons.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/models/user_model.dart';
import 'package:haajaree/screens/common_widgets/button.dart';
import 'package:haajaree/screens/common_widgets/card.dart';
import 'package:haajaree/screens/common_widgets/customtextfeild.dart';
import 'package:haajaree/routes/routes_names.dart';
import 'package:haajaree/screens/common_widgets/setDateBottomSheet.dart';
import 'package:haajaree/utils/show_taost.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EnterDetail extends StatefulWidget {
  const EnterDetail({super.key});

  @override
  State<EnterDetail> createState() => _EnterDetailState();
}

class _EnterDetailState extends State<EnterDetail> {
  final TextEditingController compneyNameController = TextEditingController();
  final TextEditingController jobTimeContoller = TextEditingController();
  final TextEditingController monthlySalaryController = TextEditingController();
  bool confirmPassShow = true;
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();

  @override
  void dispose() {
    monthlySalaryController.dispose();
    compneyNameController.dispose();
    jobTimeContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 12)),
          child: SingleChildScrollView(
            child: card(
                context: context,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 165,
                      // width: 200,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          appLogo(width: screenWidth(context)),
                          Positioned(
                            top: 98,
                            child: headingBlod(
                                text: 'Enter-Detail',
                                color: bgColor,
                                textAlign: TextAlign.center,
                                context: context),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenWidth(context, dividedBy: 40),
                          bottom: screenWidth(context, dividedBy: 30),
                          right: screenWidth(context, dividedBy: 11),
                          left: screenWidth(context, dividedBy: 11)),
                      child: Column(
                        children: [
                          customTextField(
                              controller: compneyNameController,
                              label: 'Enter Compney Name'),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 22.0),
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 5, right: 5),
                            decoration: BoxDecoration(
                              // color: Color(bgColor),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: const Color(bgColor)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      inputBold(
                                          text: 'Start Time',
                                          color: blackColor,
                                          context: context),
                                      dateTimeContainer(
                                          date: date1,
                                          onDateChange: (DateTime newDate) {
                                            setState(() => date1 = newDate);
                                          },
                                          context: context),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      inputBold(
                                          text: 'End Time',
                                          color: blackColor,
                                          context: context),
                                      dateTimeContainer(
                                          date: date2,
                                          onDateChange: (DateTime newDate) {
                                            setState(() {
                                              date2 = newDate;
                                            });
                                          },
                                          context: context),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // customTextField(
                            //     controller: jobTimeContoller,
                            //     label: 'Enter Job Time'),
                          ),
                          customTextField(
                              controller: monthlySalaryController,
                              label: 'Enter Monthly Salary'),
                          BlocConsumer<UserBloc, UserState>(
                            listener: (context, state) {
                              if (state is DbFailure) {
                                showSnakBar(context, state.error);
                              } else if (state is DbUserModelSuccess) {
                                Navigator.pushReplacementNamed(
                                    context, mainPage);
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                child: button(
                                    context: context,
                                    text: state is DbLoading ? null : 'Submit',
                                    child: state is DbLoading
                                        ? LoadingAnimationWidget.inkDrop(
                                            color: const Color(whiteColor),
                                            size: 25)
                                        : null,
                                    onTap: () {
                                      String startTime = DateFormat('hh:mm a')
                                          .format(date1.toLocal());
                                      String endTime = DateFormat('hh:mm a')
                                          .format(date2.toLocal());
                                      // String startTime =
                                      //     '${DateFormat('hh').format(date1.toLocal())}-${DateFormat('mm').format(date1.toLocal())}';
                                      // String endTime =
                                      //     '${DateFormat('hh').format(date2.toLocal())}-${DateFormat('mm').format(date2.toLocal())}';
                                      // String jobTime = '$startTime'
                                      if (compneyNameController
                                              .text.isNotEmpty &&
                                          monthlySalaryController
                                              .text.isNotEmpty) {
                                        if (context.read<AuthBloc>().state
                                            is AuthSuccess) {
                                          final authState = context
                                              .read<AuthBloc>()
                                              .state as AuthSuccess;
                                          final userModel = UserModel(
                                              email: authState.userModel.email,
                                              fullName:
                                                  authState.userModel.fullName,
                                              password:
                                                  authState.userModel.password,
                                              compneyName: compneyNameController
                                                  .text
                                                  .trim(),
                                              jobStartTime: startTime.trim(),
                                              jobEndTime: endTime.trim(),
                                              monthlySalary:
                                                  monthlySalaryController.text
                                                      .trim(),
                                              uID: authState.userModel.uID);
                                          context.read<UserBloc>().add(
                                              SetUserModelEvent(userModel));
                                        } else if (context
                                            .read<AuthBloc>()
                                            .state is AuthGoogleSuccess) {
                                          final authState = context
                                              .read<AuthBloc>()
                                              .state as AuthGoogleSuccess;
                                          final userModel = UserModel(
                                              email: authState
                                                  .userCredential.user!.email,
                                              fullName: authState.userCredential
                                                  .user!.displayName,
                                              password: authState.userCredential
                                                  .credential!.token
                                                  .toString(),
                                              compneyName: compneyNameController
                                                  .text
                                                  .trim(),
                                              jobStartTime: startTime.trim(),
                                              jobEndTime: endTime.trim(),
                                              monthlySalary:
                                                  monthlySalaryController.text
                                                      .trim(),
                                              uID: authState
                                                  .userCredential.user!.uid);
                                          context.read<UserBloc>().add(
                                              SetUserModelEvent(userModel));
                                        }
                                      } else {
                                        showSnakBar(context, 'Fill All Boxs');
                                      }
                                    }),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

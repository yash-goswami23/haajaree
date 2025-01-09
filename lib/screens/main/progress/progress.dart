import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haajaree/bloc/home_bloc/home_bloc.dart';
import 'package:haajaree/bloc/progress_bloc/progress_bloc_bloc.dart';
import 'package:haajaree/bloc/user_bloc/user_bloc.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/models/home_model.dart';
import 'package:haajaree/data/models/progress_model.dart';
import 'package:haajaree/data/models/user_model.dart';
import 'package:haajaree/data/services/admob_service.dart';
import 'package:haajaree/screens/main/progress/widgets/progress_widgets.dart';
import 'package:haajaree/utils/check_two_time_difference.dart';
import 'package:haajaree/utils/show_taost.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  bool isRight = false;
  void sideChange() {
    isRight = !isRight;
  }

  ProgressModel? progressModel;
  calculateValues(List<HomeModel> homeList, UserModel userModel) {
    int days = homeList.length; //total days
    int tp = 0; // total presents
    int ta = 0; // total absents
    int thd = 0; // total holyday
    int th = 0; // total hour
    double ths = 0.0; // total hour salary
    double ts = 0.0; // total salary
    double ti = 0.0; // total income
    int thfd = 0; // total half days
    double monthlySalary = 0; // monthly salary
    double daySalary = 0; // day salary
    // double hourSalary = 0; // hour salary
    int jobHour = 0; // job hour

    for (var element in homeList) {
      if (element.dutyStatus == 'P' || element.dutyStatus == 'POT') {
        tp = tp + 1;
      } else if (element.dutyStatus == 'A') {
        ta = ta + 1;
      } else if (element.dutyStatus == 'H') {
        thd = thd + 1;
      } else if (element.dutyStatus == 'OT') {
        thfd = thfd + 1;
      }
      if (element.overTime != null) {
        th = int.parse(element.overTime!) + th;
      }
    }
    monthlySalary = double.parse(userModel.monthlySalary.toString());
    daySalary = monthlySalary / 30;
    // Example strings
    String startTime = userModel.jobStartTime!;
    String endTime = userModel.jobEndTime!; // 12-hour format

    Duration difference = calculateTimeDifference(startTime, endTime);
    // Convert to hours and minutes
    int hours = difference.inHours;
    // int minutes = difference.inMinutes % 60;
    jobHour = hours - 1; // ds / job hour
    double hs = daySalary / jobHour;
    ths = th * hs;
    ts = tp * daySalary;
    ti = ts + ths;
    progressModel = ProgressModel(
        totalDays: days,
        totalPresents: tp,
        totalAbsents: ta,
        totalHolydays: thd,
        totalHour: th,
        totalHourMoney: ths.toInt(),
        totalSalary: ts.toInt(),
        totalIncome: ti.toInt(),
        totalHalfDays: thfd);
    if (progressModel != null) {
      context.read<ProgressBloc>().add(SetProgressEvent(progressModel!));
    }
  }

  @override
  void initState() {
    super.initState();
    AdmobService.loadInterstitialAd();
    AdmobService.loadRewardedAd();
    if (context.read<UserBloc>().state is UserInitial) {
      context.read<UserBloc>().add(GetUserModelEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 6,
                blurRadius: 6,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: AppBar(
            title: titleMedium(
              text: 'Progress',
              color: whiteColor,
              context: context,
            ),
            actions: [
              SizedBox(
                width: screenWidth(context, dividedBy: 2),
                child: AdWidget(
                  ad: AdmobService.createBannerAd()..load(),
                  key: UniqueKey(),
                ),
              ),
            ],
            backgroundColor: const Color(blueElementColor),
            // elevation: 12,
          ),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserInitial) {
            context.read<UserBloc>().add(GetUserModelEvent());
          } else if (state is UserFailure) {
            AdmobService.showRewardedAd();
            showSnakBar(context, state.error);
            context.read<UserBloc>().add(GetUserModelEvent());
          }
        },
        builder: (context, state) {
          if (state is UserSuccess) {
            AdmobService.showInterstitialAd();
            final List<HomeModel>? homeList = context.read<HomeBloc>().homeList;
            calculateValues(homeList!, state.userModel);
            final itemList = progressModel!.listOnTitleWithValue();
            return ListView.builder(
                itemCount: itemList.length,
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemBuilder: (context, index) {
                  final item = itemList[index];
                  sideChange();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: progressItem(
                        context: context,
                        title: item['title'].toString(),
                        value: item['value'].toString(),
                        isRight: isRight),
                  );
                });
          } else {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(whiteColor), size: 45),
            );
          }
        },
      ),
    );
  }
}

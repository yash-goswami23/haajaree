import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haajaree/bloc/home_bloc/home_bloc.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/models/home_model.dart';
import 'package:haajaree/data/services/admob_service.dart';
import 'package:haajaree/screens/main/home/widgets/home_main_card.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isRight = false;
  void sideChange() {
    isRight = !isRight;
  }

  List<HomeModel>? homeList;
  bool isHere = false;
  setData() {
    context.read<HomeBloc>().add(SetAttencesModelEvent(HomeModel(
        dutyStatus: '',
        overTime: '0',
        day: DateFormat('EEEE').format(DateTime.now()).toString(),
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())));
  }

  @override
  void initState() {
    super.initState();
    AdmobService.loadInterstitialAd();
    AdmobService.loadRewardedAd();
    context.read<HomeBloc>().add(GetAttenceModelEvent());
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
              text: 'Home',
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
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is DbAttencesSuccess) {
            homeList = state.homeModelList;
            for (var element in state.homeModelList) {
              if (element.date ==
                  DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()) {
                isHere = true;
              }
            }
            if (!isHere) {
              setData();
              context.read<HomeBloc>().add(GetAttenceModelEvent());
              isHere = true;
            }
          }
          if (state is HomeFirstData) {
            setData();
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(whiteColor), size: 45),
            );
          } else if (state is DbAttencesSuccess) {
            return ListView.builder(
                itemCount: state.homeModelList.length,
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemBuilder: (context, index) {
                  final model = state.homeModelList[index];
                  sideChange();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: HomeMainCard(
                        context: context,
                        hour: model.overTime.toString(),
                        date: model.date.toString(),
                        day: model.day,
                        seletedValue: model.dutyStatus,
                        saveBtn: (model) {
                          AdmobService.showRewardedAd();
                          context
                              .read<HomeBloc>()
                              .add(SetAttencesModelEvent(model));
                        },
                        isRight: isRight),
                  );
                });
          } else if (state is HomeFailure) {
            //.showInterstitialAd();
            return Center(
              child: elementRegluar(text: state.error, context: context),
            );
          } else if (state is HomeFirstData) {
            setData();
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(whiteColor), size: 45),
            );
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

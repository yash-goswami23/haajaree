import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haajaree/bloc/auth_bloc/auth_bloc.dart';
import 'package:haajaree/bloc/user_bloc/user_bloc.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/icons.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/services/admob_service.dart';
import 'package:haajaree/screens/common_widgets/button.dart';
import 'package:haajaree/screens/common_widgets/card.dart';
import 'package:haajaree/screens/common_widgets/customtextfeild.dart';
import 'package:haajaree/routes/routes_names.dart';
import 'package:haajaree/screens/main/profile/widgets/full_image.dart';
import 'package:haajaree/utils/get_initials.dart';
import 'package:haajaree/utils/set_profile_image.dart';
import 'package:haajaree/utils/show_taost.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
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
              text: 'Profile',
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
            showSnakBar(context, state.error);
            context.read<UserBloc>().add(GetUserModelEvent());
          } else if (state is UserSuccess) {
            AdmobService.showRewardedAd();
            if (state.userModel.photoUrl.isNotEmpty) {
              _selectedImage = File(state.userModel.photoUrl);
            }
          }
        },
        builder: (context, state) {
          if (state is UserSuccess) {
            if (state.userModel.photoUrl.isNotEmpty) {
              _selectedImage = File(state.userModel.photoUrl);
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 12)),
              child: Center(
                child: SingleChildScrollView(
                  child: card(
                      context: context,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: screenWidth(context, dividedBy: 11),
                                left: screenWidth(context, dividedBy: 11)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Hero(
                                    tag: 'imageHero',
                                    child: GestureDetector(
                                      onLongPress: () =>
                                          showMaterialModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => Container(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 15),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          child: Expanded(
                                            child: Column(
                                              children: [
                                                Flexible(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final xfile =
                                                              await pickImageFromGallery(
                                                                  _picker);
                                                          if (xfile != null) {
                                                            _selectedImage =
                                                                File(
                                                                    xfile.path);
                                                            context
                                                                .read<
                                                                    UserBloc>()
                                                                .add(SetUserModelEvent(state
                                                                    .userModel
                                                                    .copyWith(
                                                                        photoUrl: xfile
                                                                            .path
                                                                            .toString())));
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                        whiteColor),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        13),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                )),
                                                        child: state
                                                                is AuthLoading
                                                            ? LoadingAnimationWidget
                                                                .inkDrop(
                                                                    color: const Color(
                                                                        whiteColor),
                                                                    size: 25)
                                                            : const Text(
                                                                'Pick From Gallery',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        blueElementColor),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Flexible(
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final xfile =
                                                              await captureImageFromCamera(
                                                                  _picker);
                                                          if (xfile != null) {
                                                            _selectedImage =
                                                                File(
                                                                    xfile.path);
                                                            context
                                                                .read<
                                                                    UserBloc>()
                                                                .add(SetUserModelEvent(state
                                                                    .userModel
                                                                    .copyWith(
                                                                        photoUrl: xfile
                                                                            .path
                                                                            .toString())));
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        13),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                )),
                                                        child: const Text(
                                                          'Pick From Camera',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  blueElementColor),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (_selectedImage != null) {
                                          AdmobService.showInterstitialAd();
                                          showImage(context, _selectedImage!);
                                        } else {
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => Container(
                                              // color: Colors.transparent,
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 15),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final xfile =
                                                              await pickImageFromGallery(
                                                                  _picker);
                                                          if (xfile != null) {
                                                            _selectedImage =
                                                                File(
                                                                    xfile.path);
                                                            context
                                                                .read<
                                                                    UserBloc>()
                                                                .add(SetUserModelEvent(state
                                                                    .userModel
                                                                    .copyWith(
                                                                        photoUrl: xfile
                                                                            .path
                                                                            .toString())));

                                                            AdmobService
                                                                .showRewardedAd();
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                        whiteColor),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        13),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                )),
                                                        child: state
                                                                is AuthLoading
                                                            ? LoadingAnimationWidget
                                                                .inkDrop(
                                                                    color: const Color(
                                                                        whiteColor),
                                                                    size: 25)
                                                            : const Text(
                                                                'Pick From Gallery',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        blueElementColor),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final xfile =
                                                              await captureImageFromCamera(
                                                                  _picker);
                                                          if (xfile != null) {
                                                            _selectedImage =
                                                                File(
                                                                    xfile.path);
                                                            context
                                                                .read<
                                                                    UserBloc>()
                                                                .add(SetUserModelEvent(state
                                                                    .userModel
                                                                    .copyWith(
                                                                        photoUrl: xfile
                                                                            .path
                                                                            .toString())));
                                                            AdmobService
                                                                .showRewardedAd();
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        13),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                )),
                                                        child: const Text(
                                                          'Pick From Camera',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  blueElementColor),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: SizedBox(
                                        height: 70,
                                        width: 70,
                                        child: Stack(
                                          children: [
                                            card(
                                                context: context,
                                                padding: _selectedImage != null
                                                    ? const EdgeInsets.all(0)
                                                    : null,
                                                margin: _selectedImage != null
                                                    ? const EdgeInsets.all(0)
                                                    : null,
                                                height: 80,
                                                width: 80,
                                                image: _selectedImage != null
                                                    ? DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: FileImage(
                                                            _selectedImage!))
                                                    : null,
                                                cardColor: blueElementColor,
                                                alignment: Alignment.center,
                                                radius:
                                                    BorderRadius.circular(50),
                                                child: _selectedImage != null
                                                    ? Container()
                                                    : headingSmall(
                                                        text: getInitials(
                                                            string: state
                                                                .userModel
                                                                .fullName!,
                                                            limitTo: 2),
                                                        color: whiteColor,
                                                        context: context)),
                                            if (_selectedImage == null)
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 2.0,
                                                          top: 2.0),
                                                  child: SvgPicture.asset(
                                                    gallery,
                                                    height: 18,
                                                    width: 18,
                                                    color:
                                                        const Color(whiteColor),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    customTextField(
                                        enabled: false,
                                        controller: TextEditingController(
                                            text: state.userModel.fullName),
                                        label: 'Employee Name'),
                                    const SizedBox(height: 20),
                                    customTextField(
                                        enabled: false,
                                        controller: TextEditingController(
                                            text: state.userModel.email),
                                        label: 'Employee Email'),
                                    const SizedBox(height: 20),
                                    customTextField(
                                        enabled: false,
                                        controller: TextEditingController(
                                            text: state.userModel.compneyName),
                                        label: 'Company Name'),
                                    const SizedBox(height: 20),
                                    Container(
                                      // margin: const EdgeInsets.symmetric(vertical: 22.0),
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8, left: 5, right: 5),
                                      decoration: BoxDecoration(
                                        // color: Color(bgColor),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            color: const Color(bgColor)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              children: [
                                                inputBold(
                                                    text: 'Start Time',
                                                    color: blackColor,
                                                    context: context),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(whiteColor),
                                                    border: Border.all(
                                                        color: Colors.black38),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 8),
                                                  child: inputBold(
                                                      text: state.userModel
                                                          .jobStartTime!,
                                                      color: bgColor,
                                                      context: context),
                                                ),
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
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(whiteColor),
                                                    border: Border.all(
                                                        color: Colors.black38),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 8),
                                                  child: inputBold(
                                                      text: state.userModel
                                                          .jobEndTime!,
                                                      color: bgColor,
                                                      context: context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    customTextField(
                                        enabled: false,
                                        controller: TextEditingController(
                                            text:
                                                state.userModel.monthlySalary),
                                        label: 'Enter Monthly Salary'),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 22.0),
                                      child: button(
                                          context: context,
                                          text: 'Log-out',
                                          onTap:
                                              () =>
                                                  showMaterialModalBottomSheet(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    builder: (context) =>
                                                        Container(
                                                      // color: Colors.transparent,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8,
                                                              bottom: 15),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.18,
                                                      child: Column(
                                                        children: [
                                                          Flexible(
                                                            child: SizedBox(
                                                              width:
                                                                  screenWidth(
                                                                      context),
                                                              child:
                                                                  BlocConsumer<
                                                                      AuthBloc,
                                                                      AuthState>(
                                                                listener:
                                                                    (context,
                                                                        state) {
                                                                  if (state
                                                                      is AuthFailure) {
                                                                    showSnakBar(
                                                                        context,
                                                                        state
                                                                            .error);
                                                                  } else if (state
                                                                      is AuthInitial) {
                                                                    AdmobService
                                                                        .showRewardedAd();
                                                                    Navigator.pushNamedAndRemoveUntil(
                                                                        context,
                                                                        welcomeScreen,
                                                                        (route) =>
                                                                            false);
                                                                  }
                                                                },
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  return ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        context
                                                                            .read<AuthBloc>()
                                                                            .add(SignOutEvent());
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: const Color.fromARGB(255, 222, 222, 222),
                                                                          padding: const EdgeInsets.all(13),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          )),
                                                                      child: state is AuthLoading
                                                                          ? LoadingAnimationWidget.inkDrop(color: const Color(redColor), size: 25)
                                                                          : Text(
                                                                              'Log out',
                                                                              style: TextStyle(color: Colors.red.shade400, fontSize: 16, fontWeight: FontWeight.w500),
                                                                            ));
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Flexible(
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor: Colors.white,
                                                                      padding: const EdgeInsets.all(13),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      )),
                                                                  child: const Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            40,
                                                                            111,
                                                                            211),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          } else if (state is UserLoading) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(whiteColor), size: 45),
            );
          } else if (state is UserFailure) {
            return Center(
                child: elementRegluar(text: state.error, context: context));
          } else {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: button(
                  context: context,
                  onTap: () {},
                  text: 'Try Again',
                  textColor: bgColor,
                  btnColor: whiteColor),
            ));
          }
        },
      ),
    );
  }
}

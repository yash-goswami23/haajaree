import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haajaree/bloc/auth_bloc/auth_bloc.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/assets_paths.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/services/admob_service/admob_service.dart';
import 'package:haajaree/data/services/admob_service/banner_ads_widget.dart';
import 'package:haajaree/screens/common_widgets/button.dart';
import 'package:haajaree/screens/common_widgets/card.dart';
import 'package:haajaree/screens/common_widgets/customtextfeild.dart';
import 'package:haajaree/routes/routes_names.dart';
import 'package:haajaree/utils/show_taost.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool confirmPassShow = true;
  bool isKeyboardVisible = false;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      isKeyboardVisible = bottomInset > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(bgColor),
        actions: [
          SizedBox(
            width: screenWidth(context, dividedBy: 1),
            child: BannerAdWidget(),
          )
        ],
      ),
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
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          appLogo(width: screenWidth(context)),
                          Positioned(
                            top: 98,
                            child: headingBlod(
                                text: 'Log-in',
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 22.0),
                            child: customTextField(
                                controller: emailController,
                                label: 'Enter Email'),
                          ),
                          customTextField(
                            obscureText: confirmPassShow,
                            controller: passwordController,
                            label: 'Password',
                            suffixWidget: InkWell(
                                onTap: () {
                                  setState(() {
                                    confirmPassShow = !confirmPassShow;
                                  });
                                },
                                child: !confirmPassShow
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: Color(bgColor),
                                      )
                                    : const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Color(bgColor),
                                      )),
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthFailure) {
                                AdmobService.showAppOpenAd();
                                showSnakBar(context, state.error);
                              } else if (state is AuthSuccess) {
                                AdmobService.showRewardedAd();
                                Navigator.pushReplacementNamed(
                                    context, mainPage);
                              } else if (state is AuthGoogleSuccess) {
                                if (state.userCredential.additionalUserInfo!
                                    .isNewUser) {
                                  AdmobService.showAppOpenAd();
                                  Navigator.pushReplacementNamed(
                                      context, enterDetailScreen);
                                } else {
                                  AdmobService.showInterstitialAd();
                                  Navigator.pushReplacementNamed(
                                      context, mainPage);
                                }
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                child: button(
                                    context: context,
                                    text:
                                        state is AuthLoading ? null : 'Log-in',
                                    child: state is AuthLoading
                                        ? LoadingAnimationWidget.inkDrop(
                                            color: const Color(whiteColor),
                                            size: 25)
                                        : null,
                                    onTap: () {
                                      if (emailController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty) {
                                        context.read<AuthBloc>().add(LoginEvent(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim()));
                                      } else {
                                        showSnakBar(context, 'Fill All Boxs');
                                      }
                                    }),
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              AdmobService.showRewardedAd();
                              Navigator.pushReplacementNamed(
                                  context, createAccountScreen);
                            },
                            child: elementRegluar(
                                text: 'Create New Account',
                                color: bgColor,
                                context: context),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
      bottomSheet: isKeyboardVisible
          ? null
          : GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(SiginWithGoogle());
              },
              child: card(
                width: 100,
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: SvgPicture.asset(gmail),
                context: context,
              ),
            ),
    );
  }
}

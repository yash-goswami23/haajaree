import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haajaree/bloc/auth_bloc/auth_bloc.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/icons.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/services/admob_service.dart';
import 'package:haajaree/screens/common_widgets/button.dart';
import 'package:haajaree/screens/common_widgets/card.dart';
import 'package:haajaree/screens/common_widgets/customtextfeild.dart';
import 'package:haajaree/routes/routes_names.dart';
import 'package:haajaree/utils/show_taost.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>
    with WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameControllers = TextEditingController();
  bool confirmPassShow = true;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AdmobService.loadInterstitialAd();
    AdmobService.loadRewardedAd();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    emailController.dispose();
    fullNameControllers.dispose();
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
            child: AdWidget(
              ad: AdmobService.createBannerAd()..load(),
            ),
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
                      height: screenHeight(context, dividedBy: 4.2),
                      // width: 200,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          appLogo(
                              width: screenWidth(context),
                              height: screenHeight(context, dividedBy: 8)),
                          Positioned(
                            top: screenHeight(context, dividedBy: 10),
                            child: SizedBox(
                              width: 250,
                              child: headingBlod(
                                  text: 'Create New Account',
                                  color: bgColor,
                                  textAlign: TextAlign.center,
                                  context: context),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight(context, dividedBy: 40),
                          bottom: screenWidth(context, dividedBy: 30),
                          right: screenWidth(context, dividedBy: 11),
                          left: screenWidth(context, dividedBy: 11)),
                      child: Column(
                        children: [
                          customTextField(
                              controller: fullNameControllers,
                              label: 'Enter Full Name'),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight(context, dividedBy: 45)),
                            child: customTextField(
                              controller: emailController,
                              label: 'Enter Email',
                              validator: (value) {
                                if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value!)) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                            ),
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
                                showSnakBar(context, state.error);
                              } else if (state is AuthSuccess) {
                                Navigator.pushReplacementNamed(
                                    context, enterDetailScreen);
                              } else if (state is AuthGoogleSuccess) {
                                if (state.userCredential.additionalUserInfo!
                                    .isNewUser) {
                                  Navigator.pushReplacementNamed(
                                      context, enterDetailScreen);
                                } else {
                                  AdmobService.showRewardedAd();
                                  Navigator.pushReplacementNamed(
                                      context, mainPage);
                                }
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        screenHeight(context, dividedBy: 50)),
                                child: button(
                                    context: context,
                                    text: state is AuthLoading
                                        ? null
                                        : 'Create New Account',
                                    child: state is AuthLoading
                                        ? LoadingAnimationWidget.inkDrop(
                                            color: const Color(whiteColor),
                                            size: 25)
                                        : null,
                                    onTap: () {
                                      if (emailController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty &&
                                          fullNameControllers.text.isNotEmpty) {
                                        context.read<AuthBloc>().add(
                                            SignUpEvent(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                fullName:
                                                    fullNameControllers.text));
                                        AdmobService.showInterstitialAd();
                                      } else {
                                        showSnakBar(context, 'Fill All Boxs');
                                      }
                                    }),
                              );
                            },
                          ),
                          GestureDetector(
                              onTap: () {
                                AdmobService.showInterstitialAd();
                                Navigator.pushReplacementNamed(
                                    context, loginScreen);
                              },
                              child: elementRegluar(
                                  text: 'Log-in',
                                  color: bgColor,
                                  context: context))
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

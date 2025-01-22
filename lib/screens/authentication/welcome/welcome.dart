import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/assets_paths.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/services/admob_service.dart';
import 'package:haajaree/screens/common_widgets/button.dart';
import 'package:haajaree/screens/common_widgets/card.dart';
import 'package:haajaree/routes/routes_names.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    AdmobService.loadRewardedAd();
    // AdmobService.loadInterstitialAd();
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
      bottomNavigationBar: SizedBox(
        height: 65,
        child: AdWidget(
          ad: AdmobService.createBannerAd()..load(),
          key: UniqueKey(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 12)),
          child: card(
              context: context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: screenHeight(context, dividedBy: 5),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        appLogo(width: screenWidth(context)),
                        Positioned(
                          top: 98,
                          child: headingBlod(
                              text: 'Welcome',
                              color: bgColor,
                              context: context),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenWidth(context, dividedBy: 15),
                        bottom: screenWidth(context, dividedBy: 11),
                        right: screenWidth(context, dividedBy: 11),
                        left: screenWidth(context, dividedBy: 11)),
                    child: Column(
                      children: [
                        button(
                            context: context,
                            text: 'Create New Account',
                            onTap: () {
                              AdmobService.showInterstitialAd();
                              Navigator.pushReplacementNamed(
                                  context, createAccountScreen);
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: button(
                              context: context,
                              text: 'Login',
                              onTap: () {
                                AdmobService.showInterstitialAd();
                                Navigator.pushReplacementNamed(
                                    context, loginScreen);
                              }),
                        ),
                        button(
                            context: context,
                            text: 'How to Use',
                            onTap: () {
                              Navigator.pushNamed(context, howToVideoScreen);
                              // AdmobService.showRewardedAd();
                            }),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

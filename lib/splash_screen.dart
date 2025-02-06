import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nerdism/select_sem_page.dart';
import 'package:nerdism/splashScreen.dart';
import 'package:nerdism/theme&colors/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 100,
      backgroundColor: appBarColor,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
      // animationDuration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      splash: const SplashScreenWidget(),
      nextScreen: const FirstPage(),
    );
  }
}

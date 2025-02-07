import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nerdism/select_sem_page.dart';
import 'package:nerdism/splash_screen_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 250,
      backgroundColor: const Color(0xff16282b),
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
      curve: Curves.easeIn, splash: const SplashScreenWidget(),
      nextScreen: const FirstPage(), // Ensure you're navigating correctly
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nerdism/theme&colors/colors.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Lottie/splashscreen.gif',
    );
  }
}

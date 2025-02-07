import 'package:flutter/material.dart';
import 'package:nerdism/theme&colors/colors.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: containerColor,
            image: DecorationImage(
              image: const AssetImage('assets/a.gif'),
              fit: BoxFit.cover,
              opacity: 0.6,
              colorFilter: ColorFilter.mode(containerColor, BlendMode.dst),
            ),
          ),
          child: Align(
            alignment: Alignment.center, // Aligns text to the right
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Right align text within the column
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            fontSize: 22,
                            color: Colors.white,
                            fontFamily: 'font7'),
                      ),
                      _buildText(
                          "If you never try", Colors.white, 14, 'font8', false),
                    ],
                  ),
                  _buildText(
                      "You never know", Colors.white, 14, 'font8', false),
                  _buildText(
                      "Just what you're", Colors.white, 14, 'font8', false),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildText("\"Worth", Colors.blue, 22, 'font8', true),
                      const Text(
                        "\"",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            fontSize: 22,
                            color: Colors.blue,
                            fontFamily: 'font7'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text, Color textColour, double textSize,
      String fontFamily, bool shouldBold) {
    return Text(
      text,
      textAlign: TextAlign.center, // Align text content to right
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: textSize,
        letterSpacing: 3,
        color: textColour,
        fontWeight:
            (shouldBold || !shouldBold) ? FontWeight.bold : FontWeight.w100,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nerdism/theme&colors/colors.dart';

class QuestionBankPage extends StatefulWidget {
  const QuestionBankPage({super.key});

  @override
  State<QuestionBankPage> createState() => _QuestionBankPageState();
}

class _QuestionBankPageState extends State<QuestionBankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q u e s t i o n   Bank",
              style: TextStyle(
                color: textColor,
                fontFamily: 'font2',
              ),
            ),
            const Divider(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hold tight!",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font6'),
            ),
            Text(
              "We are working on it...",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font6'),
            ),
          ],
        )),
      ),
    );
  }
}

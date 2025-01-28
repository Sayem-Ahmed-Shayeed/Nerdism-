import 'package:flutter/material.dart';
import 'package:nerdism/theme&colors/colors.dart';

class NuraApurNote extends StatefulWidget {
  NuraApurNote({required this.title, super.key});
  String title;
  @override
  State<NuraApurNote> createState() => _NuraApurNoteState();
}

class _NuraApurNoteState extends State<NuraApurNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: textColor,
            fontFamily: 'font2',
          ),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No note is here for now.",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font6'),
            ),
            Text(
              "Come back later...",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font6'),
            ),
          ],
        ),
      ),
    );
  }
}

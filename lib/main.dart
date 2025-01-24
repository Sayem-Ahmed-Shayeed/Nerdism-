import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nerdism/course_content.dart';
import 'package:nerdism/nerdism.dart';
import 'package:nerdism/select_sem_page.dart';
import 'data_model.dart';

var kColorScheme = const Color(0xff213555);
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());
  var userInfoBox = await Hive.openBox<UserInfo>('UserBox');
  runApp(const NerdApp());
}

class NerdApp extends StatelessWidget {
  const NerdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kColorScheme,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stroopy/pages/home/nickname_page.dart';
import 'package:stroopy/pages/intro_screens/onboarding_screen.dart';
import 'package:stroopy/pages/rankings/rankings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stroopy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NicknamePage(),
      ),
    );
  }
}


          // playerName: 'Shoha',
          // playerIcon: 'assets/resource/icons/img_1.png',
          // score: 1,

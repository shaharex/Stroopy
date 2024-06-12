import 'package:flutter/material.dart';
import 'package:stroopy/pages/home/nickname_page.dart';

import 'intro_screen1.dart';
import 'intro_screen2.dart';
import 'intro_screen3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  // the one who rules them all
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final PageController _controller = PageController(
    initialPage: 0,
  );
  bool onLastPage = false;

  String onBoardingText = 'Select the correct color by reading \n the word';

  void textOnBoarding(int pageIndex) {
    setState(() {
      if (pageIndex == 0) {
        onBoardingText = 'Select the correct color by reading \n the word';
      } else if (pageIndex == 1) {
        onBoardingText = 'Check the countdown indicator';
      } else if (pageIndex == 2) {
        onBoardingText = 'Evaluate your agility';
      }
    });
  }

  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              _animationController.forward();
              setState(() {
                onLastPage = (index == 2);
              });
              textOnBoarding(index);
            },
            controller: _controller,
            children: [
              IntroScreen1(),
              IntroScreen2(
                controller: _animationController,
              ),
              IntroScreen3(),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              // dot indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                alignment: const Alignment(0, 0.63),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        _controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: AnimatedContainer(
                        curve: Curves.easeInQuad,
                        duration: const Duration(milliseconds: 300),
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (_controller.hasClients
                                  ? _controller.page?.round() == index
                                  : _controller.initialPage == index)
                              ? const Color(0xFF00A991)
                              : Colors.grey[350],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // text description
              SizedBox(
                height: 60,
                child: Text(
                  onBoardingText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // button
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                alignment: const Alignment(0, 1),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NicknamePage()));
                  },
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF00A991),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          // app bar
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/logo/img.png'),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      'Stroopy',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Score: ${(_controller.hasClients ? _controller.page?.round() == 2 : _controller.initialPage == 2) ? '1' : '0'}',
                      style: const TextStyle(
                        color: Color(0xFF00A991),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

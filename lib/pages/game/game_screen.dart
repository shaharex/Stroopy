import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../rankings/rankings_screen.dart';
import 'container_with_timer.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.playerName,
    required this.playerIcon,
  });
  final String playerName;
  final String playerIcon;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  //game
  final Random _random = Random();
  final List<String> _colorNames = [
    'B L U E',
    'Y E L L O W',
    'P U R P L E',
    'R E D',
    'G R E E N',
    'O R A N G E'
  ];
  final List<Color> _colors = [
    Color(0xff10A8FE),
    Color(0xffFFC700),
    Color(0xffC00DCF),
    Color(0xffCF0505),
    Color(0xff00A991),
    Color(0xffFFA500),
  ];

  String _displayedText = '?';
  Color _displayedColor = Color.fromARGB(255, 150, 150, 150);
  int _score = 0;
  Timer? _timer;
  List<int> _selectedIndexes = [];

  void _generateNewStroop() {
    // generate 3 unique random indexes
    _selectedIndexes = [];
    while (_selectedIndexes.length < 3) {
      int index = _random.nextInt(_colorNames.length);
      if (!_selectedIndexes.contains(index)) {
        _selectedIndexes.add(index);
      }
    }

    setState(() {
      // choose the displayed text and color from the selected subset
      int chosenIndex = _selectedIndexes[_random.nextInt(3)];

      _displayedText = _colorNames[chosenIndex];
      _displayedColor = _colors[_selectedIndexes[_random.nextInt(3)]];
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 2), () {
      _showGameOverDialog();
    });
  }

  void _checkAnswer(Color color) {
    if (color == _displayedColor) {
      setState(() {
        _score++;
        _controllerForAnimation.reset();
        _controllerForAnimation.forward();
      });
    } else {
      _showGameOverDialog();
    }
    _generateNewStroop();
    _controllerForAnimation.forward();
  }

  void _showGameOverDialog() {
    _timer?.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RankingScreen(
          playerName: widget.playerName,
          playerIcon: widget.playerIcon,
          score: _score,
        ),
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _score = 0;
      _generateNewStroop();
    });
    _controllerForAnimation.reset();
    _controllerForAnimation.forward();
  }

  // animation
  late AnimationController _controllerForAnimation;
  bool buttonIsVisible = true;

  @override
  void initState() {
    _controllerForAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controllerForAnimation.dispose();
    super.dispose();
  }

  final boxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 5,
    offset: const Offset(0, 5),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
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
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/logo/img.png'),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text(
                              'Stroopy',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(widget.playerIcon),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 100,
                        ),
                        Text(
                          'Score: $_score',
                          style: const TextStyle(
                            color: Color(0xFF00A991),
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.playerName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 620,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(70),
                      boxShadow: [boxShadow],
                    ),
                    child: Column(
                      children: [
                        Text(
                          _displayedText,
                          style: TextStyle(
                            color: _displayedColor,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        buttonIsVisible
                            ? Column(
                                children: [
                                  ContainerWithTimer(
                                    colorOfContainer: _displayedColor,
                                    bottomShadow: boxShadow,
                                    controller: _controllerForAnimation,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ContainerWithTimer(
                                    colorOfContainer: _displayedColor,
                                    bottomShadow: boxShadow,
                                    controller: _controllerForAnimation,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ContainerWithTimer(
                                    colorOfContainer: _displayedColor,
                                    bottomShadow: boxShadow,
                                    controller: _controllerForAnimation,
                                  )
                                ],
                              )
                            : Stroopers(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 70,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:
                                Image.asset('assets/resource/music/sound.png'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _generateNewStroop();
                              buttonIsVisible = false;
                              _controllerForAnimation.forward();
                            });
                          },
                          child: Visibility(
                            visible: buttonIsVisible,
                            child: Container(
                              width: 120,
                              height: 70,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                color: Color(0xff00A991),
                              ),
                              child: const Text(
                                'Start',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column Stroopers() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _selectedIndexes.map((index) {
        return GestureDetector(
          onTap: () => _checkAnswer(_colors[index]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ContainerWithTimer(
              colorOfContainer: _colors[index],
              bottomShadow: boxShadow,
              controller: _controllerForAnimation,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:stroopy/pages/home/nickname_page.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({
    Key? key,
    required this.playerName,
    required this.playerIcon,
    required this.score,
  }) : super(key: key);
  final String playerName;
  final String playerIcon;
  final int score;

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final List _rankingPlayers = [
    [
      'Yixiao',
      'assets/resource/icons/img_1.png',
      15,
    ],
    [
      'Min Li',
      'assets/resource/icons/img_2.png',
      10,
    ],
    [
      'Park',
      'assets/resource/icons/img_3.png',
      4,
    ],
    [
      'Kim Do',
      'assets/resource/icons/img_4.png',
      4,
    ],
    [
      'Christian',
      'assets/resource/icons/img_5.png',
      1,
    ],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rankingPlayers.add([widget.playerName, widget.playerIcon, widget.score]);
    _rankingPlayers.sort((a, b) => b[2].compareTo(a[2]));
  }

  BoxShadow bottomShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 6,
    offset: const Offset(0, 5),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
              height: 10,
            ),
            Container(
              height: 600,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(70),
                boxShadow: [bottomShadow],
              ),
              child: Column(
                children: [
                  const Text(
                    'Ranking',
                    style: TextStyle(
                      color: Color(0xff00A991),
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 300,
                    height: 500,
                    child: ListView.separated(
                        itemCount: _rankingPlayers.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Colors.grey[500],
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            width: 100,
                            height: 100,
                            child: Row(
                              children: [
                                Image.asset(_rankingPlayers[index][1]),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _rankingPlayers[index][0],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      'Score: ${_rankingPlayers[index][2]}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xff00A991),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Text(
              'Select a player from the top',
              style: TextStyle(
                color: Color(0xff00A991),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'or',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff10A8FE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Play again',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NicknamePage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff00A991),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'New Player',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

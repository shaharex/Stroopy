// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // the one who rules them all
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
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

  @override
  Widget build(BuildContext context) {
    const Color color = Colors.black;
    BoxShadow bottomShadow = BoxShadow(
      color: color.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 5,
      offset: const Offset(0, 5),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              _controller.forward();
            },
          );
        },
        child: const Icon(Icons.play_arrow),
      ),
      appBar: AppBar(),
      body: Center(
        child: ContainerWithTimer(
          colorOfContainer: const Color(0xFFFFC700),
          bottomShadow: bottomShadow,
          controller: _controller,
        ),
      ),
    );
  }
}

class ContainerWithTimer extends StatefulWidget {
  const ContainerWithTimer({
    super.key,
    required this.colorOfContainer,
    required this.bottomShadow,
    required this.controller,
  });
  final Color colorOfContainer;
  final BoxShadow bottomShadow;
  final AnimationController controller;
  @override
  State<ContainerWithTimer> createState() => _ContainerWithTimerState();
}

class _ContainerWithTimerState extends State<ContainerWithTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // don't use alignment, if you use it size.width and size.height will be replaced to 0
      height: 135,
      width: 135,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.colorOfContainer,
        boxShadow: [widget.bottomShadow],
      ),
      child: CustomPaint(
        painter: BorderPainter(
          controller: widget.controller,
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final AnimationController controller;

  late final Animation<double> lastAnim;
  late final Animation<double> preLastAnim;
  late final Animation<double> centerAnim;
  late final Animation<double> firstAnim;

  BorderPainter({required this.controller}) {
    firstAnim = Tween(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.fastOutSlowIn),
      ),
    );
    centerAnim = Tween(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
    preLastAnim = Tween(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.75, curve: Curves.fastOutSlowIn),
      ),
    );
    lastAnim = Tween(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final lastPercent = lastAnim.value;
    const offset = 15.0;
    final lastPaint = Paint();
    lastPaint.color = Colors.white;
    lastPaint.style = PaintingStyle.stroke;
    lastPaint.strokeWidth = 5;

    canvas.drawArc(
      Offset(offset, offset) &
          Size(size.width - offset * 2, size.height - offset * 2),
      pi / 2,
      pi * 2 * lastPercent,
      false,
      lastPaint,
    );

    final preLastPercent = preLastAnim.value;
    final preLastPaint = Paint();
    preLastPaint.color = Colors.white;
    preLastPaint.style = PaintingStyle.stroke;
    preLastPaint.strokeWidth = 5;
    canvas.drawArc(
      Offset(offset, offset) &
          Size(size.width - offset * 2, size.height - offset * 2),
      pi * 2 * preLastPercent + (pi / 2),
      pi * 2 * preLastPercent,
      false,
      preLastPaint,
    );

    final centerPercent = centerAnim.value;
    final centerPaint = Paint();
    centerPaint.color = Colors.white;
    centerPaint.style = PaintingStyle.stroke;
    centerPaint.strokeWidth = 5;
    canvas.drawArc(
      Offset(offset, offset) &
          Size(size.width - offset * 2, size.height - offset * 2),
      (pi * 3) / 2,
      pi * 2 * centerPercent,
      false,
      centerPaint,
    );

    final firstPercent = firstAnim.value;
    final firstPaint = Paint();
    firstPaint.color = Colors.white;
    firstPaint.style = PaintingStyle.stroke;
    firstPaint.strokeWidth = 5;
    canvas.drawArc(
      Offset(offset, offset) &
          Size(size.width - offset * 2, size.height - offset * 2),
      2 * pi,
      pi * 2 * firstPercent,
      false,
      firstPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

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

  BorderPainter({required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    final percent = 1.0;
    const offset = 15.0;
    final filledPaint = Paint();
    filledPaint.color = Colors.white;
    filledPaint.style = PaintingStyle.stroke;
    filledPaint.strokeWidth = 5;

    canvas.drawArc(
      Offset(offset, offset) &
          Size(size.width - offset * 2, size.height - offset * 2),
      pi / 2,
      pi * 2 * percent,
      false,
      filledPaint,
    );

    final freePaint = Paint();
    freePaint.color = Color(0xFFFFC700);
    freePaint.style = PaintingStyle.stroke;
    freePaint.strokeWidth = 5;
    canvas.drawArc(
      Offset(offset, offset) &
          Size(size.width - offset * 2, size.height - offset * 2),
      pi * 2 * percent + (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      freePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

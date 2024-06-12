import 'dart:math';

import 'package:flutter/material.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key, required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    const Color color = Colors.black;
    BoxShadow bottomShadow = BoxShadow(
      color: color.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 5,
      offset: const Offset(0, 5),
    );
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 80,
        bottom: 200,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(70),
          boxShadow: [bottomShadow],
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Y E L L O W',
              style: TextStyle(
                fontSize: 50,
                color: Color(0xFFCF0505),
                fontWeight: FontWeight.bold,
              ),
            ),
            ContainerWithTimer(
              colorOfContainer: const Color(0xffCF0505),
              bottomShadow: bottomShadow,
              controller: controller,
            ),
            const SizedBox(
              height: 10,
            ),
            ContainerWithTimer(
              colorOfContainer: const Color(0xFF00A991),
              bottomShadow: bottomShadow,
              controller: controller,
            ),
            const SizedBox(
              height: 10,
            ),
            ContainerWithTimer(
              colorOfContainer: const Color(0xFFFFC700),
              bottomShadow: bottomShadow,
              controller: controller,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
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

  late final Animation<double> firstAnim;
  late final Animation<double> centerAnim;
  late final Animation<double> preLastAnim;
  late final Animation<double> lastAnim;

  BorderPainter({required this.controller}) {
    firstAnim = _createAnimation(0.0, 0.25);
    centerAnim = _createAnimation(0.25, 0.5);
    preLastAnim = _createAnimation(0.5, 0.75);
    lastAnim = _createAnimation(0.75, 1.0);
  }

  Animation<double> _createAnimation(double begin, double end) {
    return Tween(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(begin, end, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  void _drawArc(Canvas canvas, Size size, Animation<double> animation,
      double startAngle) {
    // white animated border
    final percent = (animation == lastAnim) ? 0.25 : animation.value;
    const offset = 20.0;
    final lastPaint = Paint();
    lastPaint.color = Colors.white;
    lastPaint.style = PaintingStyle.stroke;
    lastPaint.strokeWidth = 4;

    canvas.drawArc(
      const Offset(offset, offset) &
          Size(size.width - offset * 2, size.height - offset * 2),
      startAngle,
      pi * 2 * percent,
      false,
      lastPaint,
    );

    // the shadow
    final shadowPaint = Paint();
    const shadowOffset = 14.0;
    shadowPaint.color = const Color.fromARGB(255, 59, 59, 59);
    shadowPaint.style = PaintingStyle.stroke;
    shadowPaint.strokeWidth = 1;
    shadowPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawArc(
      const Offset(shadowOffset, shadowOffset) &
          Size(size.width - shadowOffset * 2, size.height - shadowOffset * 2),
      startAngle,
      pi * 2 * percent,
      false,
      shadowPaint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawArc(canvas, size, firstAnim, 2 * pi);
    _drawArc(canvas, size, centerAnim, (pi * 3) / 2);
    _drawArc(canvas, size, preLastAnim, pi);
    _drawArc(canvas, size, lastAnim, pi / 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

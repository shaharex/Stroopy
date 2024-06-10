import 'package:flutter/material.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

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
            ),
            const SizedBox(
              height: 10,
            ),
            ContainerWithTimer(
                colorOfContainer: const Color(0xFF00A991),
                bottomShadow: bottomShadow),
            const SizedBox(
              height: 10,
            ),
            ContainerWithTimer(
                colorOfContainer: const Color(0xFFFFC700),
                bottomShadow: bottomShadow),
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
  });
  final Color colorOfContainer;
  final BoxShadow bottomShadow;

  @override
  State<ContainerWithTimer> createState() => _ContainerWithTimerState();
}

class _ContainerWithTimerState extends State<ContainerWithTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 135,
      width: 135,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.colorOfContainer,
        boxShadow: [widget.bottomShadow],
      ),
      child: Container(
        height: 105,
        width: 105,
        decoration: BoxDecoration(
          color: widget.colorOfContainer,
          boxShadow: [widget.bottomShadow],
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 4,
          ),
        ),
      ),
    );
  }
}

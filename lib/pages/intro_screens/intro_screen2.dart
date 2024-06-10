import 'package:flutter/material.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key, required this.toggle});
  final bool toggle;

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
              toggle: toggle,
              colorOfContainer: const Color(0xffCF0505),
              bottomShadow: bottomShadow,
            ),
            const SizedBox(
              height: 10,
            ),
            ContainerWithTimer(
                toggle: toggle,
                colorOfContainer: const Color(0xFF00A991),
                bottomShadow: bottomShadow),
            const SizedBox(
              height: 10,
            ),
            ContainerWithTimer(
                toggle: toggle,
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
    required this.toggle,
  });
  final Color colorOfContainer;
  final BoxShadow bottomShadow;
  final bool toggle;
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
      child: AnimatedContainer(
        curve: Curves.bounceInOut,
        duration: Duration(seconds: 2),
        height: 105,
        width: 105,
        decoration: BoxDecoration(
          color: widget.colorOfContainer,
          boxShadow: [widget.bottomShadow],
          shape: BoxShape.circle,
          border: widget.toggle
              ? Border.all(
                  width: 0,
                  color: Colors.transparent,
                )
              : Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 4,
                ),
        ),
      ),
    );
  }
}

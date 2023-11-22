import 'package:flutter/material.dart';

class AnimatedLetters extends StatefulWidget {
  const AnimatedLetters(
    this.val, {
    super.key,
  });

  final String val;

  @override
  State<AnimatedLetters> createState() => _AnimatedLettersState();
}

class _AnimatedLettersState extends State<AnimatedLetters>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late String prevLetter;
  late String curLetter;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 250),
    );
    prevLetter = widget.val;
    curLetter = widget.val;
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedLetters oldWidget) {
    if (widget.val != oldWidget.val) {
      setState(() {
        prevLetter = oldWidget.val;
        curLetter = widget.val;
        animationController
          ..reset()
          ..forward();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (_, __) {
          return SizedBox(
            width: 50,
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -animationController.value * 50),
                  child: Opacity(
                    opacity: 1 - animationController.value,
                    child: Text(prevLetter),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 50 - animationController.value * 50),
                  child: Opacity(
                    opacity: animationController.value,
                    child: Text(
                      curLetter,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';

class TextAnimation extends StatefulWidget {
  const TextAnimation({
    super.key,
    required this.isActive,
    required this.active,
    required this.nonActive,
    required this.pieceHeight,
  });

  final bool isActive;
  final double active;
  final int nonActive;
  final double pieceHeight;

  @override
  State<TextAnimation> createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late bool isUp;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 200),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(TextAnimation oldWidget) {
    if (widget.isActive && !oldWidget.isActive) {
      animationController.forward();
    } else {
      isUp = widget.active > widget.nonActive;
      animationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (_, __) {
          String lableText;
          Offset offset;

          if (animationController.isAnimating &&
              animationController.status == AnimationStatus.reverse) {
            final selNumber =
                (5 * animationController.value.round() * (isUp ? -1 : 1)) +
                    widget.nonActive;
            lableText = '$selNumber%';
            final dy = 5 *
                animationController.value *
                widget.pieceHeight *
                (isUp ? -1 : 1);
            offset = Offset(0, dy);
          } else {
            if (widget.isActive) {
              lableText = '${widget.active.toInt()}%';
              final dy =
                  widget.pieceHeight * (widget.nonActive - widget.active);
              offset = Offset(0, dy);
            } else {
              lableText = '${widget.nonActive}%';
              offset = Offset.zero;
            }
          }
          return Transform.scale(
            alignment: Alignment.centerLeft,
            scale: (animationController.value * 0.6) + 1,
            child: Transform.translate(
              offset: offset,
              child: Text(lableText),
            ),
          );
        });
  }
}

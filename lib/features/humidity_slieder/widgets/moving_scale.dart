import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_configuration.dart';
import 'package:test_task/features/humidity_slieder/widgets/text_animation.dart';

class MovingScale extends StatefulWidget {
  const MovingScale(
    this.val,
    this.pieceHeight, {
    super.key,
  });

  final double val;
  final double pieceHeight;

  @override
  State<MovingScale> createState() => _MovingScaleState();
}

class _MovingScaleState extends State<MovingScale> {
  late int activeIndex;
  late HumidityConfiguration configuration;

  @override
  void initState() {
    configuration = context.read<HumidityConfiguration>();
    activeIndex = lookForNearest(widget.val);

    super.initState();
  }

  @override
  void didUpdateWidget(MovingScale movingScaleWidget) {
    final oldWidget = configuration.list.reversed.toList()[activeIndex];
    final delta = (widget.val - oldWidget).abs().round();
    if (delta >= 5) {
      activeIndex = lookForNearest(widget.val);
    }
    super.didUpdateWidget(movingScaleWidget);
  }

  int lookForNearest(double val) {
    final element = [...configuration.list.reversed]
      ..sort((i, j) => (i - val).abs().compareTo((j - val).abs()));
    return configuration.list.length -
        configuration.list.indexOf(element.first);
  }

  @override
  Widget build(BuildContext context) {
    final list = configuration.list;
    final firsIndex = configuration.firstIndex;
    final lastIndex = configuration.lastIndex;
    return Container(
      padding: const EdgeInsets.only(left: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list.reversed
                  .toList()
                  .asMap()
                  .map(
                    (key, value) => MapEntry(
                      key,
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: value <= list[firsIndex] ||
                                    value >= list[lastIndex]
                                ? Colors.amber
                                : Colors.transparent,
                          ),
                          TextAnimation(
                              key: ValueKey(value),
                              isActive: key == activeIndex,
                              active: widget.val,
                              nonActive: value,
                              pieceHeight: widget.pieceHeight),
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_configuration.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_notifier.dart';
import 'package:test_task/features/humidity_slieder/widgets/ball_slider.dart';
import 'package:test_task/features/humidity_slieder/widgets/humidity_curve.dart';
import 'package:test_task/features/humidity_slieder/widgets/line_painter.dart';

class HandleSlider extends StatefulWidget {
  const HandleSlider(this.pieceHeight, {super.key});

  final double pieceHeight;

  @override
  State<HandleSlider> createState() => _HandleSliderState();
}

class _HandleSliderState extends State<HandleSlider> {
  double dy = 400;
  late double stepHeight;
  late double minVal;
  late double maxVal;
  late double Function(double) measureHumidity;
  late HumidityConfiguration configuration;
  late Function() updateFinalValue;
  late Function(double) updateTrasitionalValue;

  handleMove(data) {
    final newDy = (data.globalPosition.dy - 40).clamp(minVal, maxVal);

    if (dy != newDy) {
      setState(() {
        updateTrasitionalValue(measureHumidity(newDy));
        updateFinalValue();
        dy = newDy;
      });
    }
  }

  @override
  void initState() {
    updateTrasitionalValue =
        context.read<HumidityNotifier>().updateTrasitionalValue;
    updateFinalValue = context.read<HumidityNotifier>().updateFinalValue;
    configuration = context.read<HumidityConfiguration>();
    final height = widget.pieceHeight * 100;
    final paddingTop = 13 * widget.pieceHeight + 9;
    final paddingBottom = 11 * widget.pieceHeight + 9;
    final body = height - (paddingTop + paddingBottom);
    final stepsCount = configuration.list.length;
    stepHeight = body / (stepsCount - 1);
    measureHumidity = (newDy) {
      final percentage = 1 - (newDy - minVal) / (stepHeight * 5);
      final capacity = configuration.list[configuration.lastIndex] -
          configuration.list[configuration.firstIndex];
      return percentage * capacity +
          configuration.list[configuration.firstIndex];
    };
    minVal = paddingTop;
    maxVal = height - paddingBottom;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final horCenter = dy - 20;
    return SizedBox(
      width: 100,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 15,
            right: 40,
            child: CustomPaint(
              painter: LinePainter(horCenter, configuration),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 27,
            child: HumidityCurve(horCenter: horCenter),
          ),
          Positioned(
            right: 0,
            top: horCenter,
            child: GestureDetector(
              onVerticalDragStart: handleMove,
              onVerticalDragUpdate: handleMove,
              onVerticalDragEnd: (_) => updateFinalValue(),
              child: const BallSlider(),
            ),
          ),
        ],
      ),
    );
  }
}

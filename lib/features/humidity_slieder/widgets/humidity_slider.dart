import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_notifier.dart';
import 'package:test_task/features/humidity_slieder/widgets/handle_slider.dart';
import 'package:test_task/features/humidity_slieder/widgets/moving_scale.dart';

class HumiditySlider extends StatelessWidget {
  const HumiditySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constr) {
      final maxHeight = constr.maxHeight;
      final pieceHeight = maxHeight / 100;
      final val = context.watch<HumidityNotifier>().transitionalValue;
      return Row(
        children: [MovingScale(val!, pieceHeight), HandleSlider(pieceHeight)],
      );
    });
  }
}

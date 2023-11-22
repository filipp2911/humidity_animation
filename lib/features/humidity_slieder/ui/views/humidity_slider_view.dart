import 'package:flutter/material.dart';
import 'package:test_task/common/widgets/app_scaffold/app_scaffold.dart';
import 'package:test_task/features/humidity_slieder/widgets/humidity_info.dart';
import 'package:test_task/features/humidity_slieder/widgets/humidity_slider.dart';

class HumiditySliderView extends StatefulWidget {
  const HumiditySliderView({super.key});

  @override
  State<HumiditySliderView> createState() => _HumiditySliderViewState();
}

class _HumiditySliderViewState extends State<HumiditySliderView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Container(
      alignment: Alignment.center,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 230,
            child: HumiditySlider(),
          ),
          Expanded(child: HumidityInfo())
        ],
      ),
    ));
  }
}

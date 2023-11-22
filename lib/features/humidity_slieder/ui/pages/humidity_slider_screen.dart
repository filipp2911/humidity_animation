import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/features/humidity_slieder/ui/views/humidity_slider_view.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_configuration.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_notifier.dart';

class HumiditySliderScreen extends StatelessWidget {
  const HumiditySliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => HumidityConfiguration(),
        ),
        ChangeNotifierProvider(
          create: (_) => HumidityNotifier(),
        ),
      ],
      child: const HumiditySliderView(),
    );
  }
}

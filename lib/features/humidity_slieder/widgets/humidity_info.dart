import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/features/humidity_slieder/utils/humidity_notifier.dart';
import 'package:test_task/features/humidity_slieder/widgets/animated_letters.dart';

class HumidityInfo extends StatelessWidget {
  const HumidityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final val = context.watch<HumidityNotifier>().finalValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(
          flex: 2,
        ),
        Container(
          height: 500,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Return Temperature'),
              const Spacer(
                flex: 10,
              ),
              const Text('30℃'),
              const Spacer(flex: 50),
              const Text('Current humidity'),
              const Spacer(flex: 10),
              Row(
                children: [
                  AnimatedLetters(
                    val.toString(),
                  ),
                  const SizedBox(
                    child: Text('%'),
                  ),
                ],
              ),
              const Spacer(flex: 40),
              const Text('Absolute humidity'),
              const Spacer(flex: 12),
              const Text(
                '4gr/fg3',
              ),
              const Spacer(flex: 42),
              const Icon(
                Icons.warning_amber_outlined,
                color: Colors.yellow,
              ),
              const Spacer(
                flex: 10,
              ),
              RichText(
                text: const TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.yellow,
                      ),
                    ),
                    TextSpan(
                      style: TextStyle(height: 1.3, color: Colors.black),
                      text:
                          ' — extreme humidity level. \n Use precaution for set-points \n outside of 20%-50%',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

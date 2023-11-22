import 'package:flutter/material.dart';

class BallSlider extends StatelessWidget {
  const BallSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber[50],
      ),
      height: 40,
      width: 40,
      alignment: Alignment.center,
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.grey,
        size: 20,
      ),
    );
  }
}

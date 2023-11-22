import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body,
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 5),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/features/humidity_slieder/ui/pages/humidity_slider_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Size _designSize = _selectDesignSize();

  Size _selectDesignSize() {
    const mbSize = Size(414, 896);
    if (!kIsWeb) return mbSize;

    var shortestSide = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    ).size.shortestSide;

    return shortestSide < 600 ? mbSize : const Size(1920, 1080);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: _designSize,
        rebuildFactor: (old, data) {
          final size = _selectDesignSize();

          if (size != _designSize) {
            setState(() => _designSize = size);
          }

          return old.size != data.size;
        },
        builder: (ctx, chld) {
          return const HumiditySliderScreen();
        });
  }
}

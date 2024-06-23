import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/HomePage/HomePage.dart';

void main() {
  runApp(TheatreApp());
}

class TheatreApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TheatreAppState();
}

class TheatreAppState extends State<TheatreApp> {
  String _windowSize = 'Unknown';

  Future _getWindowSize() async {
    var size = await DesktopWindow.getWindowSize();
    await DesktopWindow.setMinWindowSize(Size(1920,1080));
    await DesktopWindow.setMaxWindowSize(Size(1920,1080));
  }

  @override
  void initState() {
    _getWindowSize();
    print(_windowSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

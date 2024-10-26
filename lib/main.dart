import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/lefty_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Widget _currentBody = const MainLayout();
  double _opacity = 1.0;

  void _changeBody() {
    setState(() {
      _opacity = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        if (_currentBody is MainLayout) {
          _currentBody = const MainLayout2();
        } else {
          _currentBody = const MainLayout();
        }
        _opacity = 1.0; // Start fade-in effect
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/menu.png',
              height: 32,
              width: 32,
            ),
            onPressed: () {
              _changeBody();
            },
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: Text(
                'Rell Drum',
                style: TextStyle(
                  color: Color(0xffcbd237),
                  fontSize: 30,
                ),
              ),
            ),
          ),
          backgroundColor: const Color(0xff101720),
          toolbarHeight: 50,
          actions: [
            IconButton(
              icon: Image.asset(
                'assets/icons/rightoleft.png',
                height: 32,
                width: 32,
              ),
              onPressed: () {
                _changeBody();
              },
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: _currentBody
      ),
    );
  }
}



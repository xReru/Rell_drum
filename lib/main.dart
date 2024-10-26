import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Rell Drum',
                    style: TextStyle(
                      color: Color(0xffcbd237),
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xff101720),
            toolbarHeight: 40,
          ),
          body: const MainLayout()),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 620, // x
          top: 210, // y
          child: Image.asset(
            'assets/images/openhh.png',
            fit: BoxFit.contain,
            height: 150,
            width: 150,
          ),
        ),
        Positioned(
          left: 160, // x
          top: 200, // y
          child: Image.asset(
            'assets/images/kick.png',
            fit: BoxFit.contain,
            height: 180,
            width: 180,
          ),
        ),
        Positioned(
          left: 420, // x
          top: 200, // y
          child: Image.asset(
            'assets/images/kick.png',
            fit: BoxFit.contain,
            height: 180,
            width: 180,
          ),
        ),
        Positioned(
          left: 295, // x
          top: 180, // y
          child: Image.asset(
            'assets/images/snare.png',
            fit: BoxFit.contain,
            height: 165,
            width: 165,
          ),
        ),
        Positioned(
          left:600, // x
          top: 180, // y
          child: Image.asset(
            'assets/images/floor.png',
            fit: BoxFit.contain,
            height: 180,
            width: 180,
          ),
        ),
        Positioned(
          left: 170, // x
          top: 135, // y
          child: Image.asset(
            'assets/images/tom.png',
            fit: BoxFit.contain,
            height: 140,
            width: 140,
          ),
        ),
        Positioned(
          left: 310, // x
          top: 100, // y
          child: Image.asset(
            'assets/images/tom.png',
            fit: BoxFit.contain,
            height: 140,
            width: 140,
          ),
        ),
        Positioned(
          left: 450, // x
          top: 135, // y
          child: Image.asset(
            'assets/images/tom.png',
            fit: BoxFit.contain,
            height: 140,
            width: 140,
          ),
        ),
        Positioned(
          left: 410, // x
          top: 40, // y
          child: Image.asset(
            'assets/images/crash.png',
            fit: BoxFit.contain,
            height: 145,
            width: 145,
          ),
        ),
        Positioned(
          left: 560, // x
          top: 40, // y
          child: Image.asset(
            'assets/images/ride.png',
            fit: BoxFit.contain,
            height: 170,
            width: 170,
          ),
        ),
        Positioned(
          left: 57, // x
          top: 125, // y
          child: Image.asset(
            'assets/images/closehh.png',
            fit: BoxFit.contain,
            height: 150,
            width: 150,
          ),
        ),
        Positioned(
          left: 160, // x
          top: 20, // y
          child: Image.asset(
            'assets/images/crash.png',
            fit: BoxFit.contain,
            height: 170,
            width: 170,
          ),
        ),
        
      ],
    )));
  }
}

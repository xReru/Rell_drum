import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/lefty_ui.dart';
import 'screens/musicplayer.dart';
import 'screens/about.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _currentBody = const MainLayout();
  double _opacity = 1.0;

  void _changeBody() {
    setState(() {
      _opacity = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _currentBody = _currentBody is MainLayout
            ? const MainLayout2()
            : const MainLayout();
        _opacity = 1.0; // Start fade-in effect
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              icon: Image.asset(
                'assets/icons/menu.png',
                height: 32,
                width: 32,
              ),
              onPressed: () {
                _scaffoldKey.currentState
                    ?.openDrawer(); // Open the drawer programmatically
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
          drawer: Drawer(
            child: Container(
              color: const Color(
                  0xff101720), // Background color of the whole drawer
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: 100,
                    color: const Color(
                        0xff101720), // Drawer header background color
                    child: const DrawerHeader(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Rell Drum',
                        style: TextStyle(
                          color: Color(0xffcbd237),
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    tileColor: const Color(
                        0xff101720), // Background color of each ListTile
                    leading: const Icon(Icons.home, color: Color(0xffcbd237)),
                    title: const Text(
                      'Home',
                      style: TextStyle(color: Color(0xffcbd237)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentBody = const MainLayout();
                      });
                    },
                  ),
                  ListTile(
                    tileColor: const Color(0xff101720),
                    leading:
                        const Icon(Icons.settings, color: Color(0xffcbd237)),
                    title: const Text(
                      'Settings',
                      style: TextStyle(color: Color(0xffcbd237)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentBody = const MusicPlayer();
                      });
                    },
                  ),
                  ListTile(
                    tileColor: const Color(0xff101720),
                    leading: const Icon(Icons.info, color: Color(0xffcbd237)),
                    title: const Text(
                      'About',
                      style: TextStyle(color: Color(0xffcbd237)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AboutLayout(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: _currentBody),
    );
  }
}

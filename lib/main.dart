import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/lefty_ui.dart';
import 'screens/musicplayer.dart';
import 'screens/about.dart';
import 'screens/music_choose.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
        _opacity = 1.0;
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: const Color(0xff101720),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/icons/menu.png',
                      height: 24, width: 24),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                const Spacer(),
                const Text(
                  'Rell Drum',
                  style: TextStyle(
                    color: Color(0xffEEC640),
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.music_note,
                              color: Color(0xffEEC640)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MusicChoose(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.settings,
                              color: Color(0xffEEC640)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutLayout(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon:
                              const Icon(Icons.info, color: Color(0xffEEC640)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutLayout(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/icons/rightoleft.png',
                          height: 24, width: 24),
                      onPressed: _changeBody,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: const Text(
                  'Rell Drum',
                  style: TextStyle(color: Color(0xffEEC640), fontSize: 24),
                ),
                decoration: const BoxDecoration(color: Color(0xff101720)),
              ),
              ListTile(
                leading: const Icon(Icons.music_note_rounded,
                    color: Color(0xffEEC640)),
                title: const Text('Play Music',
                    style: TextStyle(color: Color(0xffEEC640))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Color(0xffEEC640)),
                title: const Text('Settings',
                    style: TextStyle(color: Color(0xffEEC640))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Color(0xffEEC640)),
                title: const Text('About',
                    style: TextStyle(color: Color(0xffEEC640))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutLayout(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 300),
          child: _currentBody,
        ),
      ),
    );
  }
}

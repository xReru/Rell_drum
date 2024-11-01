import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MainLayout2 extends StatefulWidget {
  const MainLayout2({super.key});

  @override
  State<MainLayout2> createState() => _MainLayout2State();
}

class _MainLayout2State extends State<MainLayout2>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        12,
        (index) => AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 30),
            ));
    _scaleAnimations = _controllers
        .map((controller) =>
            Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            )))
        .toList();
  }

  void _onTap(int index) {
    // Start the zoom-in animation for the tapped image
    _controllers[index].forward().then((_) {
      Future.delayed(const Duration(milliseconds: 30), () {
        _controllers[index].reverse();
      });
    });

    // Play the corresponding audio
    switch (index) {
      case 0:
        _playAudio('openhh');
        break;
      case 1:
        _playAudio('kick');
        break;
      case 2:
        _playAudio('kick');
        break;
      case 3:
        _playAudio('snare');
        break;
      case 4:
        _playAudio('floor');
        break;
      case 5:
        _playAudio('tom1');
        break;
      case 6:
        _playAudio('tom2');
        break;
      case 7:
        _playAudio('tom3');
        break;
      case 8:
        _playAudio('crashr');
        break;
      case 9:
        _playAudio('ride');
        break;
      case 10:
        _playAudio('closehh');
        break;
      case 11:
        _playAudio('crashl');
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
              right: 620,
              top: 210,
              child: GestureDetector(
                onTapDown: (_) => _onTap(0),
                child: ScaleTransition(
                  scale: _scaleAnimations[0],
                  child: Image.asset(
                    'assets/images/openhh.png',
                    fit: BoxFit.contain,
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 160,
              top: 200,
              child: GestureDetector(
                onTapDown: (_) => _onTap(1),
                child: ScaleTransition(
                  scale: _scaleAnimations[1],
                  child: Image.asset(
                    'assets/images/kickr.png',
                    fit: BoxFit.contain,
                    height: 180,
                    width: 180,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 420,
              top: 200,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(2),
                  child: ScaleTransition(
                    scale: _scaleAnimations[2],
                    child: Image.asset(
                      'assets/images/kickl.png',
                      fit: BoxFit.contain,
                      height: 180,
                      width: 180,
                    ),
                  )),
            ),
            Positioned(
              left: 295,
              top: 190,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(3),
                  child: ScaleTransition(
                    scale: _scaleAnimations[3],
                    child: Image.asset(
                      'assets/images/snare.png',
                      fit: BoxFit.contain,
                      height: 165,
                      width: 165,
                    ),
                  )),
            ),
            Positioned(
              left: 600,
              top: 180,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(4),
                  child: ScaleTransition(
                    scale: _scaleAnimations[4],
                    child: Image.asset(
                      'assets/images/floor.png',
                      fit: BoxFit.contain,
                      height: 180,
                      width: 180,
                    ),
                  )),
            ),
            Positioned(
                left: 200,
                top: 135,
                child: GestureDetector(
                  onTapDown: (_) => _onTap(5),
                  child: ScaleTransition(
                    scale: _scaleAnimations[5],
                    child: Image.asset(
                      'assets/images/tom1.png',
                      fit: BoxFit.contain,
                      height: 140,
                      width: 140,
                    ),
                  ),
                )),
            Positioned(
              left: 420,
              top: 135,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(7),
                  child: ScaleTransition(
                    scale: _scaleAnimations[7],
                    child: Image.asset(
                      'assets/images/tom3.png',
                      fit: BoxFit.contain,
                      height: 140,
                      width: 140,
                    ),
                  )),
            ),
            Positioned(
                left: 310,
                top: 100,
                child: GestureDetector(
                  onTapDown: (_) => _onTap(6),
                  child: ScaleTransition(
                    scale: _scaleAnimations[6],
                    child: Image.asset(
                      'assets/images/tom2.png',
                      fit: BoxFit.contain,
                      height: 140,
                      width: 140,
                    ),
                  ),
                )),
            Positioned(
              left: 410,
              top: 40,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(8),
                  child: ScaleTransition(
                    scale: _scaleAnimations[8],
                    child: Image.asset(
                      'assets/images/crashr.png',
                      fit: BoxFit.contain,
                      height: 145,
                      width: 145,
                    ),
                  )),
            ),
            Positioned(
              left: 560,
              top: 40,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(9),
                  child: ScaleTransition(
                    scale: _scaleAnimations[9],
                    child: Image.asset(
                      'assets/images/ride.png',
                      fit: BoxFit.contain,
                      height: 170,
                      width: 170,
                    ),
                  )),
            ),
            Positioned(
              left: 57,
              top: 125,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(10),
                  child: ScaleTransition(
                    scale: _scaleAnimations[10],
                    child: Image.asset(
                      'assets/images/closehh.png',
                      fit: BoxFit.contain,
                      height: 150,
                      width: 150,
                    ),
                  )),
            ),
            Positioned(
              left: 160,
              top: 20,
              child: GestureDetector(
                  onTapDown: (_) => _onTap(11),
                  child: ScaleTransition(
                    scale: _scaleAnimations[11],
                    child: Image.asset(
                      'assets/images/crashl.png',
                      fit: BoxFit.contain,
                      height: 170,
                      width: 170,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _playAudio(String soundName) async {
    try {
      final audioPlayer = AudioPlayer();
      await audioPlayer.play(AssetSource('audio/$soundName.mp3'));
      audioPlayer.onPlayerComplete.listen((_) {
        audioPlayer.dispose();
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }
}

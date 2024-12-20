import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'home.dart';
import 'lefty_ui.dart';

class MusicPlayer extends StatefulWidget {
  final String filePath;

  const MusicPlayer({super.key, required this.filePath});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double _volume = 0.5; // Default volume level (50%)
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

  Color _getColorWithOpacity(double opacity) {
    int alpha = (opacity * 255).round(); // Convert opacity to alpha value
    return Color((alpha << 24) | 0xff101720);
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _audioPlayer.setSourceDeviceFile(widget.filePath);
    _audioPlayer.play(DeviceFileSource(widget.filePath));
    _audioPlayer.setVolume(_volume); // Set the initial volume
    setState(() {
      isPlaying = true;
    });
  }

  void _pauseMusic() {
    _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void _resumeMusic() {
    _audioPlayer.resume();
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _skipBack() async {
    Duration? currentPosition = await _audioPlayer.getCurrentPosition();
    if (currentPosition != null) {
      final newPosition = currentPosition - const Duration(seconds: 10);
      _audioPlayer
          .seek(newPosition > Duration.zero ? newPosition : Duration.zero);
    }
  }

  Future<void> _skipForward() async {
    Duration? currentPosition = await _audioPlayer.getCurrentPosition();
    Duration? totalDuration = await _audioPlayer.getDuration();
    if (currentPosition != null && totalDuration != null) {
      final newPosition = currentPosition + const Duration(seconds: 10);
      _audioPlayer
          .seek(newPosition < totalDuration ? newPosition : totalDuration);
    }
  }

  void _onVolumeChanged(double value) {
    setState(() {
      _volume = value;
      _audioPlayer.setVolume(_volume);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _showVolumeSlider(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff101720),
          content: SizedBox(
            width: 250,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Music Volume',
                  style: TextStyle(
                    color: Color(0xffEEC640),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10), // Space between label and slider
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Slider(
                      value: _volume,
                      onChanged: (value) {
                        _onVolumeChanged(value);
                        setState(() {
                          _volume = value;
                        });
                      },
                      min: 0.0,
                      max: 1.0,
                      activeColor: const Color(0xffEEC640),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xffeec640)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          color: const Color(0xff101720),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xffEEC640)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Rell Drum',
                style: TextStyle(
                  fontFamily: 'GoodTiming',
                  color: Color(0xffEEC640),
                  fontSize: 30,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous_rounded,
                        color: Color(0xffEEC640)),
                    onPressed: _skipBack,
                  ),
                  IconButton(
                    icon: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: const Color(0xffEEC640)),
                    onPressed: isPlaying ? _pauseMusic : _resumeMusic,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next_rounded,
                        color: Color(0xffEEC640)),
                    onPressed: _skipForward,
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up_rounded,
                        color: Color(0xffEEC640)),
                    onPressed: () => _showVolumeSlider(context),
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
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: _getColorWithOpacity(_opacity),
          ),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 300),
            child: _currentBody,
          ),
        ],
      ),
    );
  }
}

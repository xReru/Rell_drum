import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rell_drum/screens/home.dart';

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
      _audioPlayer.setVolume(_volume); // Update the volume based on the slider
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
          width: 300, // Set a fixed width for the slider
          height: 100, // Set a fixed height for the slider
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Slider(
                value: _volume, // Use the current volume for the slider
                onChanged: (value) {
                  _onVolumeChanged(value); // Update volume and UI
                  setState(() {
                    _volume = value; // Update the local state of the slider
                  });
                },
                min: 0.0,
                max: 1.0,
                activeColor: const Color(0xffEEC640),
              );
            },
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
      appBar: AppBar(
        title: const Text(
          'Play Music',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xffeec640),
          ),
        ),
        backgroundColor: const Color(0xff101720),
        iconTheme: const IconThemeData(
          color: Color(0xffeec640),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.skip_previous_rounded),
            onPressed: _skipBack,
          ),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            ),
            onPressed: isPlaying ? _pauseMusic : _resumeMusic,
          ),
          IconButton(
            icon: const Icon(Icons.skip_next_rounded),
            onPressed: _skipForward,
          ),
          IconButton(
            icon: const Icon(Icons.volume_up_rounded),
            onPressed: () => _showVolumeSlider(context), // Show volume slider dialog
          ),
        ],
      ),
      body: const Expanded(child: MainLayout()),
    );
  }
}

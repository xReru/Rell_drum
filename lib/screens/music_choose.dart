import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'musicplayer.dart';

class MusicChoose extends StatefulWidget {
  const MusicChoose({super.key});

  @override
  _MusicChooseState createState() => _MusicChooseState();
}

class _MusicChooseState extends State<MusicChoose> {
  final List<FileSystemEntity> _musicFiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _requestStoragePermission();
  }

  Future<void> _requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      _loadMusicFiles();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Storage permission is required to access music files."),
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMusicFiles() async {
    final Directory? musicDir = Directory('/storage/emulated/0/Music');

    if (musicDir != null && musicDir.existsSync()) {
      await for (var file in musicDir.list(recursive: false, followLinks: false)) {
        if (file.path.endsWith('.mp3')) {
          setState(() => _musicFiles.add(file));
        }
      }
    }

    setState(() => _isLoading = false);
  }

  void _selectMusic(String path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicPlayer(filePath: path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Music', style: TextStyle(color: Color(0xffEEC640))),
        backgroundColor: const Color(0xff101720),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _musicFiles.isEmpty
              ? const Center(
                  child: Text("No music files found.", style: TextStyle(color: Color(0xffEEC640))),
                )
              : ListView.builder(
                  itemCount: _musicFiles.length,
                  itemBuilder: (context, index) {
                    final file = _musicFiles[index];
                    return ListTile(
                      title: Text(
                        file.path.split('/').last,
                        style: const TextStyle(color: Color(0xffEEC640)),
                      ),
                      leading: const Icon(Icons.music_note, color: Color(0xffEEC640)),
                      onTap: () => _selectMusic(file.path),
                    );
                  },
                ),
    );
  }
}

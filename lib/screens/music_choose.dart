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
  final List<FileSystemEntity> _filteredMusicFiles = [];
  final TextEditingController _searchController = TextEditingController();
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
          content:
              Text("Storage permission is required to access music files."),
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMusicFiles() async {
    final Directory? musicDir = Directory('/storage/emulated/0/Music');

    if (musicDir != null && musicDir.existsSync()) {
      await for (var file
          in musicDir.list(recursive: false, followLinks: false)) {
        if (file.path.endsWith('.mp3')) {
          setState(() {
            _musicFiles.add(file);
            _filteredMusicFiles.add(file);
          });
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

  void _filterMusicFiles(String query) {
    setState(() {
      _filteredMusicFiles.clear();
      if (query.isEmpty) {
        _filteredMusicFiles.addAll(_musicFiles);
      } else {
        _filteredMusicFiles.addAll(_musicFiles.where((file) => file.path
            .split('/')
            .last
            .toLowerCase()
            .contains(query.toLowerCase())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Music...',
                  hintStyle: TextStyle(color: Color(0xffEEC640)),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Color(0xffEEC640)),
                onChanged: _filterMusicFiles,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Color(0xffEEC640)),
              onPressed: () {
                FocusScope.of(context).unfocus(); // Hide keyboard
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xff101720),
        iconTheme: const IconThemeData(
          color: Color(0xffEEC640),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredMusicFiles.isEmpty
              ? const Center(
                  child: Text("No music files found.",
                      style: TextStyle(color: Color(0xffEEC640))),
                )
              : ListView.builder(
                  itemCount: _filteredMusicFiles.length,
                  itemBuilder: (context, index) {
                    final file = _filteredMusicFiles[index];
                    return ListTile(
                      title: Text(
                        file.path.split('/').last,
                        style: const TextStyle(color: Color(0xffEEC640)),
                      ),
                      leading: const Icon(Icons.music_note,
                          color: Color(0xffEEC640)),
                      onTap: () => _selectMusic(file.path),
                    );
                  },
                ),
      backgroundColor: const Color(0xff101720),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

}

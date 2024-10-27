import 'package:flutter/material.dart';

class AboutLayout extends StatefulWidget {
  const AboutLayout({super.key});

  @override
  State<AboutLayout> createState() => AboutLayoutState();
}

class AboutLayoutState extends State<AboutLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff101720),
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: const Color(0xff101720),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xffcbd237),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade300, // Placeholder color
                child: const Center(
                  child: Text(
                    'Image Here',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Rell Drum',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff101720),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'This is an app designed to bring rhythm and beats to your fingertips. Explore, create, and enjoy music!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff101720),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

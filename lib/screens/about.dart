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
      appBar: AppBar(
        title: const Text(
          'About',
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/about_bg.png'), 
            fit: BoxFit
                .cover, 
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xff101720).withOpacity(
                  0.8), 
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.0),
                Text(
                  'RELL DRUM',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffeec640),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '\" This is an app designed to bring rhythm and beats to your fingertips. \" \n\t\" Explore, create, and enjoy music! \"\n\nDeveloped by Janrell Quiaroro \nBSCS 3-1\n\nSpecial thanks to Realdrum.app for the assets!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffeec640),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

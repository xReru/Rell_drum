import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutLayout extends StatefulWidget {
  const AboutLayout({super.key});

  @override
  State<AboutLayout> createState() => AboutLayoutState();
}

class AboutLayoutState extends State<AboutLayout> {
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(
            fontFamily: 'GoodTiming',
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
            image: AssetImage('assets/images/about_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xff101720).withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'RELL DRUM',
                  style: TextStyle(
                    fontFamily: 'GoodTiming',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffeec640),
                  ),
                ),
                const SizedBox(height: 8.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'GoodTiming',
                      fontWeight: FontWeight.w100,
                      fontSize: 16,
                      color: Color(0xffeec640),
                    ),
                    children: [
                      const TextSpan(
                        text:
                            '" This is an app designed to bring rhythm and beats to your fingertips. " \n\t" Explore, create, and enjoy music! "\n\nDeveloped by ',
                      ),
                      TextSpan(
                          text: 'Janrell Quiaroro',
                          style: const TextStyle(
                            fontFamily: 'GoodTiming',
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              const gitUrl = 'https://github.com/xReru';
                              await _launchUrl(gitUrl);
                            }),
                      const TextSpan(
                        text: ' \nBSCS 3-1\n\nSpecial thanks to ',
                      ),
                      TextSpan(
                        text: 'Realdrum.app',
                        style: const TextStyle(
                          fontFamily: 'GoodTiming',
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            const realDrumUrl = 'https://realdrum.app';
                            await _launchUrl(realDrumUrl);
                          },
                      ),
                      const TextSpan(
                        text: ' for the assets!',
                      ),
                    ],
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

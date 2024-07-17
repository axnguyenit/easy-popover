import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const PopoverExampleApp());
}

class PopoverExampleApp extends StatefulWidget {
  const PopoverExampleApp({super.key});

  @override
  State<PopoverExampleApp> createState() => _PopoverExampleAppState();
}

class _PopoverExampleAppState extends State<PopoverExampleApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Popover Example',
      home: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return const HomeScreen();
            },
          ),
        ],
      ),
    );
  }
}

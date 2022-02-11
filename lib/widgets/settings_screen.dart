import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Color(0xFFF7F8F9), width: 2)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0XFF00A3FF)),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:weather/widgets/adding_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Color(0xFFF7F8F9), width: 2)),
        actions: [IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddingScreen()),
            );
          }, icon: const Icon(Icons.add))],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0XFF00A3FF)),
        title: const Text(
          "Saved",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

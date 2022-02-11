import 'package:flutter/material.dart';

class AddingScreen extends StatelessWidget {
  const AddingScreen({Key? key}) : super(key: key);

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
        title: Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: const TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter town name'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<dynamic>> fetchTownsList(String query) async {
  final response = await http.get(Uri.parse(
      'https://www.metaweather.com/api/location/search/?query=$query'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load towns list');
  }
}

class AddingScreen extends StatefulWidget {
  const AddingScreen({Key? key}) : super(key: key);

  @override
  State<AddingScreen> createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  final townController = TextEditingController();
  String query = 'empty';
  late Future<List<dynamic>> townsList = fetchTownsList(query);
  void submitData() {
    var enteredTown = townController.text;
    if (enteredTown.isEmpty) {
      enteredTown = 'empty';
    }
    setState(() {
      query = enteredTown;
      townsList = fetchTownsList(query);
    });
  }

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
          child: TextField(
            autofocus: true,
            controller: townController,
            onChanged: (_) => submitData(),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter town name',
            ),
          ),
        ),
      ),
      body: SizedBox(
        child: FutureBuilder<List<dynamic>>(
          future: townsList,
          builder: (context, snapshot) {
            if (query == 'empty') {
              return const SizedBox();
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!.map<Widget>((town) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(town['title']),
                      ),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xFFF7F8F9)))),
                    );
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';



Future<dynamic>? fetchTownsList(String query) async {
  final response = await http.get(Uri.parse(
      'https://www.metaweather.com/api/location/search/?query=$query'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load towns list');
  }
}

class AddingScreen extends StatefulWidget {
  final Function addNewTown;
  const AddingScreen(this.addNewTown, {Key? key}) : super(key: key);

  @override
  State<AddingScreen> createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  final townController = TextEditingController();
  List<String> savedTowns = [];
  String query = 'empty';
  Future<dynamic>? townsList;
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
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerLeft,
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
          child: FutureBuilder<dynamic>(
            future: townsList,
            builder: (context, snapshot) {
              if (query == 'empty' || snapshot.data == null) {
                return const SizedBox.shrink();
              } else if (snapshot.data.isEmpty) {
                return const Center(
                  child: Text(
                    'Nothing found',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        widget.addNewTown(snapshot.data![index]['woeid']);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(snapshot.data[index]['title']),
                        ),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xFFF7F8F9)))),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}

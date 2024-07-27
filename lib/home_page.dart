import 'dart:convert';
import 'dart:io';
import 'package:api_dropdown/models/dropdown_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<DropdownItemModels>> getPost() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
      final data = jsonDecode(response.body) as List;
      if (response.statusCode == 200) {
        return data.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemModels(
            userId: map['userId'],
            id: map['id'],
            title: map['title'],
          );
        }).toList();
      }
    } on SocketException {
      throw Exception('network error');
    }
    throw Exception('Fetch data error');
  }

  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown item from API'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder
          <List<DropdownItemModels>>
          (
            future: getPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                    hint: Text('select'),
                    value: selectedValue,
                    dropdownColor: Colors.blue[100],
                    // isExpanded: true,
                    items: snapshot.data!.map((e) {
                      return DropdownMenuItem(
                          value: e.id.toString(),
                          child: Text(e.title.toString()));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    });
              } else if (snapshot.hasError) {
                return Text('error:${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}

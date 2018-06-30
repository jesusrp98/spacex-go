import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'launch_cell.dart';
import 'launch.dart';
import 'dart:convert';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Project: Cherry',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RobotoMono',
      ),
      home: new MyHomePage(title: 'Project: Cherry'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  Future<List<Launch>> fetchPost() async {
    // Get request
    final response =
        await http.get('https://api.spacexdata.com/v2/launches/upcoming');

    print('Respose code is ${response.statusCode}.');
    // If request was successful
    if (response.statusCode == 200) {
      List jsonDecoded = json.decode(response.body);
      return jsonDecoded.map((m) => new Launch.fromJson(m)).toList();
    } else
      throw Exception('Fail :(');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: Center(
        child: FutureBuilder<List<Launch>>(
          future: fetchPost(),
          builder: (context, snapshot) {
            // If has data to display
            if (snapshot.hasData) {
              List<Launch> list = snapshot.data;
              // List from upcoming launches
              return new ListView(
                children: list.map((list) => LaunchCell(list)).toList(),
              );
            } else if (snapshot.hasError) return Text("${snapshot.error}");

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
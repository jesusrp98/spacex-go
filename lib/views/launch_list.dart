import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'launch_cell.dart';
import '../classes/launch.dart';

class LaunchList extends StatelessWidget {
  final String _url;

  LaunchList(this._url);

  Future<List<Launch>> fetchPost() async {
    // Get request
    final response = await http.get(_url);

    // If request was successful
    if (response.statusCode == 200) {
      List jsonDecoded = json.decode(response.body);
      return jsonDecoded.map((m) => new Launch.fromJson(m)).toList();
    } else
      throw Exception('Fail :(');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Launch>>(
        future: fetchPost(),
        builder: (context, snapshot) {
          // If has data to display
          if (snapshot.hasData) {
            List<Launch> list = snapshot.data;
            // List from upcoming launches
            return ListView(
              padding: EdgeInsets.all(8.0),
              children: list.map((m) => LaunchCell(m)).toList(),
            );
          } else if (snapshot.hasError) return Text("${snapshot.error}");

          // By default, show a loading spinner
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

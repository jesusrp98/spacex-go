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
    final response = await http.get(_url);

    List jsonDecoded = json.decode(response.body);
    return jsonDecoded.map((m) => new Launch.fromJson(m)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: PageStorageKey(_url),
      child: FutureBuilder<List<Launch>>(
        future: fetchPost(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError)
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: snapshot.data.map((m) => LaunchCell(m)).toList(),
                );
              else
                return Text("Couldn't connect to server...");
          }
        },
      ),
    );
  }
}
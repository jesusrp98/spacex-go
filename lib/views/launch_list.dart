import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'launch_cell.dart';
import '../classes/launch.dart';

class LaunchList extends StatelessWidget {
  final String url;

  LaunchList(this.url);

  Future<List<Launch>> fetchPost(BuildContext context) async {
    final response = await http.get(url);

    List jsonDecoded = json.decode(response.body);
    return jsonDecoded.map((m) => Launch.fromJson(m)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (PageStorage.of(context).readState(context, identifier: ValueKey(url)) ==
        null)
      PageStorage
          .of(context)
          .writeState(context, fetchPost(context), identifier: ValueKey(url));

    return Center(
      child: FutureBuilder<List<Launch>>(
        future: PageStorage
            .of(context)
            .readState(context, identifier: ValueKey(url)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError) {
                final List<Launch> launches = snapshot.data;
                return ListView.builder(
                  key: PageStorageKey(url),
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  itemCount: launches.length,
                  itemBuilder: (context, index) {
                    return LaunchCell(launches[index]);
                  },
                );
              } else
                return const Text("Couldn't connect to server...");
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import '../classes/core_details.dart';

class CorePage extends StatelessWidget {
  static String url = 'https://api.spacexdata.com/v2/parts/cores/';
  final String coreSerial;
  static CoreDetails coreDetails;

  CorePage(this.coreSerial);

  Future<CoreDetails> fetchPost() async {
    final response = await http.get(url + coreSerial);

    Map<String, dynamic> jsonDecoded = json.decode(response.body);
    return CoreDetails.fromJson(jsonDecoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Core details'),
        ),
        body: Center(
          child: FutureBuilder<CoreDetails>(
            future: fetchPost(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (!snapshot.hasError) {
                    coreDetails = snapshot.data;
                    return buildCards();
                  } else
                    return Text("Couldn't connect to server...");
              }
            },
          ),
        ));
  }

  Widget buildCards() {
    return Text(coreDetails.status);
  }
}

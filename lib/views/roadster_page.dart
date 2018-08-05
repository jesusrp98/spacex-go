import 'package:cherry/classes/roadster.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class RoadsterPage extends StatelessWidget {
  static List<String> popupItems = ['Wikipedia link'];

  Future<Roadster> fetchPost() async {
    final response =
        await http.get('https://api.spacexdata.com/v2/info/roadster');

    return Roadster.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Roadster tracker'), actions: <Widget>[
        PopupMenuButton<String>(
          itemBuilder: (context) {
            return popupItems.map((item) {
              return PopupMenuItem(value: item, child: Text(item));
            }).toList();
          },
          onSelected: (String option) async =>
              await FlutterWebBrowser.openWebPage(
                url:
                    'https://en.wikipedia.org/wiki/Elon_Musk%27s_Tesla_Roadster',
                androidToolbarColor: primaryColor,
              ),
        ),
      ]),
      body: FutureBuilder<Roadster>(
        future: fetchPost(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError) {
                final Roadster roadster = snapshot.data;
                return Scrollbar(
                  child: ListView(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: <Widget>[
                        _roadsterCard(context, roadster),
                        const SizedBox(height: 8.0),
                        _vehicleCard(roadster),
                        const SizedBox(height: 8.0),
                        _orbitCard(roadster),
                      ]),
                    )
                  ]),
                );
              } else
                return const Text("Couldn't connect to server...");
          }
        },
      ),
    );
  }

  Widget _roadsterCard(BuildContext context, Roadster roadster) {
    //hero | Tesla Roadster, Elon Musk, date, description
    return HeadCardPage();
  }

  Widget _vehicleCard(Roadster roadster) {
    //Launch mass, speed, earth & mars distance
    return CardPage();
  }

  Widget _orbitCard(Roadster roadster) {
    //Orbit, inclination, longitude, apoapsis, periapsis
    return CardPage();
  }
}

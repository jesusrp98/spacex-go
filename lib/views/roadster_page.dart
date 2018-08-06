import 'package:cherry/classes/roadster.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class RoadsterPage extends StatelessWidget {
  static List<String> popupItems = ['Wikipedia page'];

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
        body: Center(
          child: FutureBuilder<Roadster>(
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
                            const SizedBox(height: 8.0),
                            Text(
                              'Data is updated every 5 minutes',
                              style:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        color: secondaryText,
                                      ),
                            )
                          ]),
                        )
                      ]),
                    );
                  } else
                    return const Text("Couldn't connect to server...");
              }
            },
          ),
        ));
  }

  Widget _roadsterCard(BuildContext context, Roadster roadster) {
    return HeadCardPage(
      image: HeroImage().buildHero(
        context: context,
        size: 116.0,
        url: roadster.imageUrl,
        tag: roadster.name,
        title: roadster.name,
      ),
      head: <Widget>[
        Text(
          roadster.name,
          style: Theme
              .of(context)
              .textTheme
              .headline
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12.0),
        Text(
          roadster.owner,
          style: Theme
              .of(context)
              .textTheme
              .subhead
              .copyWith(color: secondaryText),
        ),
        const SizedBox(height: 12.0),
        Text(
          roadster.getDate,
          style: Theme
              .of(context)
              .textTheme
              .subhead
              .copyWith(color: secondaryText),
        ),
      ],
      details: roadster.details,
    );
  }

  Widget _vehicleCard(Roadster roadster) {
    //Launch mass, speed, earth & mars distance
    return CardPage(title: 'VEHICLE', body: <Widget>[
      RowItem.textRow('Launch mass', roadster.getLaunchMass),
      const SizedBox(height: 12.0),
      RowItem.textRow('Speed', roadster.getSpeed),
      const SizedBox(height: 12.0),
      RowItem.textRow('Earth distance', roadster.getEarthDistance),
      const SizedBox(height: 12.0),
      RowItem.textRow('Mars distance', roadster.getMarsDistance),
    ]);
  }

  Widget _orbitCard(Roadster roadster) {
    //Orbit, inclination, longitude, apoapsis, periapsis
    return CardPage(title: 'ORBIT', body: <Widget>[
      RowItem.textRow('Orbit type', roadster.getOrbit),
      const SizedBox(height: 12.0),
      RowItem.textRow('Period', roadster.getPeriod),
      const SizedBox(height: 12.0),
      RowItem.textRow('Inclination', roadster.getInclination),
      const SizedBox(height: 12.0),
      RowItem.textRow('Longitude', roadster.getLongitude),
      const SizedBox(height: 12.0),
      RowItem.textRow('Apoapsis', roadster.getApoapsis),
      const SizedBox(height: 12.0),
      RowItem.textRow('Periapsis', roadster.getPeriapsis),
    ]);
  }
}

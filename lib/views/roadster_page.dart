import 'package:cherry/classes/roadster.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

/// ROADSTER PAGE CLASS
/// Displays live information about Elon Musk's Tesla Roadster.
class RoadsterPage extends StatelessWidget {
  final Roadster roadster;

  RoadsterPage(this.roadster);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Roadster tracker'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.public),
              onPressed: () async => await FlutterWebBrowser.openWebPage(
                  url: roadster.url, androidToolbarColor: primaryColor),
              tooltip: 'Wikipedia article',
            )
          ]),
      body: Scrollbar(
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
                style: Theme.of(context).textTheme.subhead.copyWith(
                      color: secondaryText,
                    ),
              )
            ]),
          )
        ]),
      ),
    );
  }

  Widget _roadsterCard(BuildContext context, Roadster roadster) {
    return HeadCardPage(
      image: HeroImage().buildHero(
        context: context,
        size: 116.0,
        url: roadster.getImageUrl,
        tag: roadster.id,
        title: roadster.name,
      ),
      title: roadster.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            roadster.getDate,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            roadster.subtitle,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
        ],
      ),
      details: roadster.description,
    );
  }

  Widget _vehicleCard(Roadster roadster) {
    return CardPage(title: 'VEHICLE', body: <Widget>[
      RowItem.textRow('Total mass', roadster.getMass),
      const SizedBox(height: 12.0),
      RowItem.textRow('Height', roadster.getHeight),
      const SizedBox(height: 12.0),
      RowItem.textRow('Diameter', roadster.getDiameter),
      const SizedBox(height: 12.0),
      RowItem.textRow('Speed', roadster.getSpeed),
      const Divider(height: 24.0),
      RowItem.textRow('Earth distance', roadster.getEarthDistance),
      const SizedBox(height: 12.0),
      RowItem.textRow('Mars distance', roadster.getMarsDistance),
    ]);
  }

  Widget _orbitCard(Roadster roadster) {
    return CardPage(title: 'ORBIT', body: <Widget>[
      RowItem.textRow('Orbit type', roadster.getOrbit),
      const SizedBox(height: 12.0),
      RowItem.textRow('Period', roadster.getPeriod),
      const Divider(height: 24.0),
      RowItem.textRow('Inclination', roadster.getInclination),
      const SizedBox(height: 12.0),
      RowItem.textRow('Longitude', roadster.getLongitude),
      const Divider(height: 24.0),
      RowItem.textRow('Apoapsis', roadster.getApoapsis),
      const SizedBox(height: 12.0),
      RowItem.textRow('Periapsis', roadster.getPeriapsis),
    ]);
  }
}

import 'package:cherry/classes/rocket_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

/// ROCKET PAGE CLASS
/// This class represent a rocket page. It displays RocketInfo's specs.
class RocketPage extends StatelessWidget {
  final RocketInfo _rocket;

  RocketPage(this._rocket);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Rocket details'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.public),
              onPressed: () async => await FlutterWebBrowser.openWebPage(
                  url: _rocket.url, androidToolbarColor: primaryColor),
              tooltip: 'Wikipedia article',
            )
          ]),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              _rocketCard(context),
              const SizedBox(height: 8.0),
              _specsCard(),
              const SizedBox(height: 8.0),
              _payloadsCard(),
              const SizedBox(height: 8.0),
              _enginesCard(),
            ]),
          )
        ]),
      ),
    );
  }

  Widget _rocketCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage().buildHero(
        context: context,
        size: 116.0,
        url: _rocket.getImageUrl,
        tag: _rocket.id,
        title: _rocket.name,
      ),
      title: _rocket.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _rocket.getLaunchTime,
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            'Success rate: ${_rocket.getSuccessRate}',
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
        ],
      ),
      details: _rocket.description,
    );
  }

  Widget _specsCard() {
    return CardPage(title: 'SPECIFICATIONS', body: <Widget>[
      RowItem.iconRow('Reusable', _rocket.reusable),
      const SizedBox(height: 12.0),
      RowItem.textRow('Launch cost', _rocket.getLaunchCost),
      const SizedBox(height: 12.0),
      RowItem.textRow('Rocket stages', _rocket.getStages),
      const SizedBox(height: 12.0),
      RowItem.textRow('Height', _rocket.getHeight),
      const SizedBox(height: 12.0),
      RowItem.textRow('Diameter', _rocket.getDiameter),
      const SizedBox(height: 12.0),
      RowItem.textRow('Total mass', _rocket.getMass),
    ]);
  }

  Widget _payloadsCard() {
    return CardPage(
      title: 'PAYLOAD CAPACITY',
      body: _combineList(_rocket.payloadWeights
          .map((payloadWeight) => _getPayloadWeight(payloadWeight))
          .toList()),
    );
  }

  List<Widget> _getPayloadWeight(PayloadWeight payloadWeight) {
    return <Widget>[
      RowItem.textRow(payloadWeight.name, payloadWeight.getMass),
      const SizedBox(height: 12.0),
    ];
  }

  List<Widget> _combineList(List<List<Widget>> map) {
    final List<Widget> finalList = List();

    for (List<Widget> list in map)
      for (Widget widget in list) finalList.add(widget);

    return finalList..removeLast();
  }

  Widget _enginesCard() {
    return CardPage(title: 'ENGINES', body: <Widget>[
      RowItem.textRow('Engine model', _rocket.getEngine),
      const SizedBox(height: 12.0),
      RowItem.textRow('First stage engines', _rocket.firstStageEngines),
      const SizedBox(height: 12.0),
      RowItem.textRow('Second stage engines', _rocket.secondStageEngines),
      const SizedBox(height: 12.0),
      RowItem.textRow('Primary fuel', _rocket.getFuel),
      const SizedBox(height: 12.0),
      RowItem.textRow('Oxidizer', _rocket.getOxidizer),
      const SizedBox(height: 12.0),
      RowItem.textRow('Thrust to weight', _rocket.getThrustToWeight),
      const SizedBox(height: 12.0),
      RowItem.textRow('Sea level thrust', _rocket.getEngineThrustSea),
      const SizedBox(height: 12.0),
      RowItem.textRow('Vacuum thrust', _rocket.getEngineThrustVacuum),
    ]);
  }
}

import 'package:cherry/classes/rocket_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:flutter/material.dart';

/// ROCKET PAGE CLASS
/// This class represent a rocket page. It displays RocketInfo's specs.
class RocketPage extends StatelessWidget {
  final RocketInfo rocket;

  RocketPage(this.rocket);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rocket details')),
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
        url: rocket.getImageUrl,
        tag: rocket.id,
        title: rocket.name,
      ),
      head: <Widget>[
        Text(
          rocket.name,
          style: Theme
              .of(context)
              .textTheme
              .headline
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12.0),
        Text(
          rocket.getLaunchTime,
          style: Theme
              .of(context)
              .textTheme
              .subhead
              .copyWith(color: secondaryText),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Success rate: ${rocket.getSuccessRate}',
          style: Theme
              .of(context)
              .textTheme
              .subhead
              .copyWith(color: secondaryText),
        ),
      ],
      details: rocket.description,
    );
  }

  Widget _specsCard() {
    return CardPage(title: 'SPECIFICATIONS', body: <Widget>[
      RowItem.iconRow('Reusable', rocket.reusable),
      const SizedBox(height: 12.0),
      RowItem.textRow('Launch cost', rocket.getLaunchCost),
      const SizedBox(height: 12.0),
      RowItem.textRow('Rocket stages', rocket.getStages),
      const SizedBox(height: 12.0),
      RowItem.textRow('Height', rocket.getHeight),
      const SizedBox(height: 12.0),
      RowItem.textRow('Diameter', rocket.getDiameter),
      const SizedBox(height: 12.0),
      RowItem.textRow('Total mass', rocket.getMass),
    ]);
  }

  Widget _payloadsCard() {
    return CardPage(
      title: 'PAYLOAD CAPACITY',
      body: _combineList(rocket.payloadWeights
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
      RowItem.textRow('Engine model', rocket.getEngine),
      const SizedBox(height: 12.0),
      RowItem.textRow('First stage engines', rocket.firstStageEngines),
      const SizedBox(height: 12.0),
      RowItem.textRow('Second stage engines', rocket.secondStageEngines),
      const SizedBox(height: 12.0),
      RowItem.textRow('Primary fuel', rocket.primaryFuel),
      const SizedBox(height: 12.0),
      RowItem.textRow('Secondary fuel', rocket.secondaryFuel),
      const SizedBox(height: 12.0),
      RowItem.textRow('Sea level thrust', rocket.getEngineThrustSea),
      const SizedBox(height: 12.0),
      RowItem.textRow('Vacuum thrust', rocket.getEngineThrustVacuum),
    ]);
  }
}

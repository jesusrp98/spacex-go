import 'package:cherry/classes/capsule_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

/// CAPSULE PAGE CLASS
/// This class represent a capsule page. It displays CapsuleInfo's specs.
class CapsulePage extends StatelessWidget {
  final CapsuleInfo _capsule;

  CapsulePage(this._capsule);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: const Text('Capsule details')),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.public),
              onPressed: () async => await FlutterWebBrowser.openWebPage(
                  url: _capsule.url, androidToolbarColor: primaryColor),
              tooltip: 'Wikipedia article',
            )
          ]),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            _capsuleCard(context),
            const SizedBox(height: 8.0),
            _specsCard(),
            const SizedBox(height: 8.0),
            _thrustersCard(),
          ]),
        ),
      ]),
    );
  }

  Widget _capsuleCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage().buildHero(
        context: context,
        size: 116.0,
        url: _capsule.getImageUrl,
        tag: _capsule.id,
        title: _capsule.name,
      ),
      title: _capsule.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _capsule.subtitle,
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            _capsule.status,
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
        ],
      ),
      details: _capsule.description,
    );
  }

  Widget _specsCard() {
    return CardPage(title: 'SPECIFICATIONS', body: <Widget>[
      RowItem.textRow('Crew capacity', _capsule.getCrew),
      const SizedBox(height: 12.0),
      RowItem.textRow('Launch payload', _capsule.getLaunchMass),
      const SizedBox(height: 12.0),
      RowItem.textRow('Return paylaod', _capsule.getReturnMass),
      const SizedBox(height: 12.0),
      RowItem.textRow('Height', _capsule.getHeight),
      const SizedBox(height: 12.0),
      RowItem.textRow('Diameter', _capsule.getDiameter),
    ]);
  }

  Widget _thrustersCard() {
    return CardPage(
      title: 'THRUSTERS',
      body: <Widget>[
        RowItem.textRow('Thruster systems', _capsule.getThrusters),
        Column(
          children: _capsule.thrusters
              .map((thruster) => _getThruster(thruster))
              .toList(),
        )
      ],
    );
  }

  Widget _getThruster(Thruster thruster) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.textRow('Thruster name', thruster.name),
      const SizedBox(height: 12.0),
      RowItem.textRow('Amount', thruster.getAmount),
      const SizedBox(height: 12.0),
      RowItem.textRow('Primary fuel', thruster.primaryFuel),
      const SizedBox(height: 12.0),
      RowItem.textRow('Secondary fuel', thruster.secondaryFuel),
      const SizedBox(height: 12.0),
      RowItem.textRow('Thrust', thruster.getThrust),
    ]);
  }
}

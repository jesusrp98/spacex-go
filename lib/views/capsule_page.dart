import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../classes/capsule_info.dart';
import '../colors.dart';
import '../widgets/card_page.dart';
import '../widgets/head_card_page.dart';
import '../widgets/hero_image.dart';
import '../widgets/row_item.dart';

/// CAPSULE PAGE CLASS
/// This class represent a capsule page. It displays CapsuleInfo's specs.
class CapsulePage extends StatelessWidget {
  final CapsuleInfo _capsule;

  CapsulePage(this._capsule);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capsule details'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () async => await FlutterWebBrowser.openWebPage(
                url: _capsule.url, androidToolbarColor: primaryColor),
            tooltip: 'Wikipedia article',
          )
        ],
      ),
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
      image: HeroImage().buildExpandedHero(
        context: context,
        size: HeroImage.bigSize,
        url: _capsule.getImageUrl,
        tag: _capsule.id,
        title: _capsule.name,
      ),
      title: _capsule.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _capsule.firstLaunched,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            _capsule.capsuleType,
            style: Theme.of(context)
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
    return CardPage(
      title: 'SPECIFICATIONS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Crew capacity', _capsule.getCrew),
          const SizedBox(height: 12.0),
          RowItem.iconRow('Reusable', _capsule.reusable),
          const Divider(height: 24.0),
          RowItem.textRow('Launch payload', _capsule.getLaunchMass),
          const SizedBox(height: 12.0),
          RowItem.textRow('Return paylaod', _capsule.getReturnMass),
          const Divider(height: 24.0),
          RowItem.textRow('Height', _capsule.getHeight),
          const SizedBox(height: 12.0),
          RowItem.textRow('Diameter', _capsule.getDiameter),
          const SizedBox(height: 12.0),
          RowItem.textRow('Dry mass', _capsule.getMass),
        ],
      ),
    );
  }

  Widget _thrustersCard() {
    return CardPage(
      title: 'THRUSTERS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Thruster systems', _capsule.getThrusters),
          Column(
            children: _capsule.thrusters
                .map((thruster) => _getThruster(thruster))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _getThruster(Thruster thruster) {
    return Column(children: <Widget>[
      const Divider(height: 24.0),
      RowItem.textRow('Thruster name', thruster.name),
      const SizedBox(height: 12.0),
      RowItem.textRow('Amount', thruster.getAmount),
      const SizedBox(height: 12.0),
      RowItem.textRow('Primary fuel', thruster.getFuel),
      const SizedBox(height: 12.0),
      RowItem.textRow('Oxidizer', thruster.getOxidizer),
      const SizedBox(height: 12.0),
      RowItem.textRow('Thrust', thruster.getThrust),
    ]);
  }
}

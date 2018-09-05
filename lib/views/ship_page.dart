import 'package:cherry/classes/ship_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:flutter/material.dart';

/// SHIP PAGE CLASS
/// This class represent a ship page. It displays Ship's specs.
class ShipPage extends StatelessWidget {
  final ShipInfo _ship;

  ShipPage(this._ship);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ship details'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              _shipCard(context),
              const SizedBox(height: 8.0),
              _specsCard(),
              (_ship.isLandable)
                  ? Column(
                      children: <Widget>[
                        const SizedBox(height: 8.0),
                        _landingsCard(),
                      ],
                    )
                  : const SizedBox(height: 0.0),
            ]),
          )
        ]),
      ),
    );
  }

  Widget _shipCard(BuildContext context) {
    return HeadCardPage(
      image: HeroImage().buildHero(
        context: context,
        size: 116.0,
        url: _ship.getImageUrl,
        tag: _ship.id,
        title: _ship.name,
      ),
      title: _ship.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _ship.getHomePort,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
          const SizedBox(height: 12.0),
          Text(
            _ship.subtitle,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: secondaryText),
          ),
        ],
      ),
      details: _ship.description,
    );
  }

  Widget _specsCard() {
    return CardPage(title: 'SPECIFICATIONS', body: <Widget>[
      (_ship.hasModel)
          ? RowItem.textRow('Ship model', _ship.model)
          : RowItem.iconRow('Ship model', null),
      const SizedBox(height: 12.0),
      RowItem.textRow('Used for', _ship.use),
      const Divider(height: 24.0),
      RowItem.textRow('Primary role', _ship.primaryRole),
      (_ship.hasSeveralRoles)
          ? Column(
        children: <Widget>[
          const SizedBox(height: 12.0),
          RowItem.textRow('Secondary role', _ship.secondaryRole),
          const SizedBox(height: 12.0),
        ],
      )
          : const SizedBox(height: 12.0),
      RowItem.textRow('Status', _ship.getStatus),
      const SizedBox(height: 12.0),
      RowItem.textRow('Coordinates', _ship.getCoordinates),
      const Divider(height: 24.0),
      RowItem.textRow('Total mass', _ship.getMass),
      const SizedBox(height: 12.0),
      RowItem.textRow('Current speed', _ship.getSpeed),
    ]);
  }

  Widget _landingsCard() {
    return CardPage(title: 'LANDINGS', body: <Widget>[
      RowItem.textRow('Attempted landings', _ship.getAttemptedLandings),
      const SizedBox(height: 12.0),
      RowItem.textRow('Successful ladings', _ship.getSuccessfulLandings),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../classes/ship_info.dart';
import '../colors.dart';
import '../widgets/card_page.dart';
import '../widgets/head_card_page.dart';
import '../widgets/hero_image.dart';
import '../widgets/row_item.dart';

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () async {
              if (_ship.hasUrl)
                await FlutterWebBrowser.openWebPage(
                    url: _ship.url, androidToolbarColor: primaryColor);
              else
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Unavailable link'),
                        content: Text(
                          'Link has not been yet provided by the service. Please try again at a later time.',
                        ),
                        actions: <Widget>[
                          FlatButton(
                              child: Text('OK'),
                              onPressed: () => Navigator.of(context).pop()),
                        ],
                      ),
                );
            },
            tooltip: 'MarineTraffic page',
          )
        ],
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
      image: HeroImage().buildExpandedHero(
        context: context,
        size: HeroImage.bigSize,
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
    return CardPage(
      title: 'SPECIFICATIONS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Feature', _ship.use),
          const SizedBox(height: 12.0),
          RowItem.textRow('Ship model', _ship.getModel),
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
        ],
      ),
    );
  }

  Widget _landingsCard() {
    return CardPage(
      title: 'LANDINGS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem.textRow('Attempted landings', _ship.getAttemptedLandings),
          const SizedBox(height: 12.0),
          RowItem.textRow('Successful landings', _ship.getSuccessfulLandings),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';
import 'package:share/share.dart';

import '../../data/models/index.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../widgets/index.dart';

/// This view all information about a Dragon capsule model. It displays CapsuleInfo's specs.
class DragonPage extends StatelessWidget {
  final CapsuleInfo _dragon;

  const DragonPage(this._dragon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _dragon.name,
          header: SwiperHeader(
            list: _dragon.photos,
            builder: (context, index) {
              final CacheImage photo = CacheImage(_dragon.getPhoto(index));
              return index == 0 ? Hero(tag: _dragon.id, child: photo) : photo;
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(
                FlutterI18n.translate(
                  context,
                  'spacex.other.share.capsule.body',
                  {
                    'name': _dragon.name,
                    'launch_payload': _dragon.getLaunchMass,
                    'return_payload': _dragon.getReturnMass,
                    'people': _dragon.isCrewEnabled
                        ? FlutterI18n.translate(
                            context,
                            'spacex.other.share.capsule.people',
                            {'people': _dragon.crew.toString()},
                          )
                        : FlutterI18n.translate(
                            context,
                            'spacex.other.share.capsule.no_people',
                          ),
                    'details': Url.shareDetails
                  },
                ),
              ),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.menu.share',
              ),
            ),
            PopupMenuButton<String>(
              itemBuilder: (context) => Menu.wikipedia
                  .map((string) => PopupMenuItem(
                        value: string,
                        child: Text(FlutterI18n.translate(context, string)),
                      ))
                  .toList(),
              onSelected: (text) => FlutterWebBrowser.openWebPage(
                url: _dragon.url,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: RowLayout.cards(children: <Widget>[
            _capsuleCard(context),
            _specsCard(context),
            _thrustersCard(context),
          ]),
        ),
      ]),
    );
  }

  Widget _capsuleCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.description.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.launch_maiden',
          ),
          _dragon.getFullFirstFlight,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.crew_capacity',
          ),
          _dragon.getCrew(context),
        ),
        RowIcon(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.active',
          ),
          _dragon.active,
        ),
        Separator.divider(),
        TextExpand(_dragon.description)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.specifications.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_launch',
          ),
          _dragon.getLaunchMass,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_return',
          ),
          _dragon.getReturnMass,
        ),
        RowIcon(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.reusable',
          ),
          _dragon.reusable,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.height',
          ),
          _dragon.getHeight,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.diameter',
          ),
          _dragon.getDiameter,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.mass',
          ),
          _dragon.getMass(context),
        ),
      ]),
    );
  }

  Widget _thrustersCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.thruster.title',
      ),
      body: RowLayout(children: <Widget>[
        for (final thruster in _dragon.thrusters)
          _getThruster(
            context: context,
            thruster: thruster,
            isFirst: _dragon.thrusters.first == thruster,
          ),
      ]),
    );
  }

  Widget _getThruster({BuildContext context, Thruster thruster, bool isFirst}) {
    return RowLayout(children: <Widget>[
      if (!isFirst) Separator.divider(),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.model',
        ),
        thruster.model,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.amount',
        ),
        thruster.getAmount,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.fuel',
        ),
        thruster.getFuel,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.oxidizer',
        ),
        thruster.getOxidizer,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.thrust',
        ),
        thruster.getThrust,
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';
import 'package:share/share.dart';

import '../../data/models/index.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../widgets/index.dart';

/// This view all information about a specific ship. It displays Ship's specs.
class ShipPage extends StatelessWidget {
  final ShipInfo _ship;

  const ShipPage(this._ship);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _ship.name,
          header: InkWell(
            onTap: () => FlutterWebBrowser.openWebPage(
              url: _ship.getProfilePhoto,
              androidToolbarColor: Theme.of(context).primaryColor,
            ),
            child: Hero(
              tag: _ship.id,
              child: CacheImage(_ship?.getProfilePhoto),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(
                FlutterI18n.translate(
                  context,
                  'spacex.other.share.ship.body',
                  {
                    'date': _ship.getBuiltFullDate,
                    'name': _ship.name,
                    'role': _ship.primaryRole,
                    'port': _ship.homePort,
                    'missions': _ship.hasMissions
                        ? FlutterI18n.translate(
                            context,
                            'spacex.other.share.ship.missions',
                            {'missions': _ship.missions.length.toString()},
                          )
                        : FlutterI18n.translate(
                            context,
                            'spacex.other.share.ship.any_missions',
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
              itemBuilder: (context) => Menu.ship
                  .map((string) => PopupMenuItem(
                        value: string,
                        child: Text(FlutterI18n.translate(context, string)),
                      ))
                  .toList(),
              onSelected: (text) => FlutterWebBrowser.openWebPage(
                url: _ship.url,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: RowLayout.cards(children: <Widget>[
            _shipCard(context),
            _specsCard(context),
            _missionsCard(context),
          ]),
        ),
      ]),
    );
  }

  Widget _shipCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.description.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.description.home_port',
            ),
            _ship.homePort),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.description.built_date',
          ),
          _ship.getBuiltFullDate,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.feature',
          ),
          _ship.use,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.model',
          ),
          _ship.getModel(context),
        ),
        if (_ship.hasExtras) ...<Widget>[
          Separator.divider(),
          if (_ship.isLandable)
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.vehicle.ship.description.landings_successful',
              ),
              _ship.getSuccessfulLandings,
            )
          else
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.vehicle.ship.description.catches_successful',
              ),
              _ship.getSuccessfulCatches,
            ),
        ]
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.specifications.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.role_primary',
          ),
          _ship.primaryRole,
        ),
        if (_ship.hasSeveralRoles)
          RowText(
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.specifications.role_secondary',
            ),
            _ship.secondaryRole,
          ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.status',
          ),
          _ship.getStatus(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.coordinates',
          ),
          _ship.getCoordinates(context),
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.mass',
          ),
          _ship.getMass(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.speed',
          ),
          _ship.getSpeed(context),
        ),
      ]),
    );
  }

  Widget _missionsCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.missions.title',
      ),
      body: _ship.hasMissions
          ? RowLayout(
              children: <Widget>[
                if (_ship.missions.length > 5) ...[
                  for (final mission in _ship.missions.sublist(0, 5))
                    RowText(
                      FlutterI18n.translate(
                        context,
                        'spacex.vehicle.ship.missions.mission',
                        {'number': mission.id.toString()},
                      ),
                      mission.name,
                    ),
                  RowExpand(RowLayout(
                    children: <Widget>[
                      for (final mission in _ship.missions.sublist(5))
                        RowText(
                          FlutterI18n.translate(
                            context,
                            'spacex.vehicle.ship.missions.mission',
                            {'number': mission.id.toString()},
                          ),
                          mission.name,
                        ),
                    ],
                  ))
                ] else
                  for (final mission in _ship.missions)
                    RowText(
                      FlutterI18n.translate(
                        context,
                        'spacex.vehicle.ship.missions.mission',
                        {'number': mission.id.toString()},
                      ),
                      mission.name,
                    ),
              ],
            )
          : Text(
              FlutterI18n.translate(
                context,
                'spacex.vehicle.ship.missions.no_missions',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
    );
  }
}

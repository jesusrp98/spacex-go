import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:share/share.dart';

import '../../models/info_ship.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../../widgets/cache_image.dart';
import '../../widgets/card_page.dart';
import '../../widgets/row_item.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';

/// SHIP PAGE VIEW
/// This view all information about a specific ship. It displays Ship's specs.
class ShipPage extends StatelessWidget {
  final ShipInfo _ship;

  ShipPage(this._ship);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: Text(_ship.name),
          header: InkWell(
            child: Hero(
              tag: _ship.id,
              child: CacheImage(_ship?.getProfilePhoto),
            ),
            onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: _ship.getProfilePhoto,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
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
              itemBuilder: (_) => Menu.ship
                  .map((string) => PopupMenuItem(
                        value: string,
                        child: Text(FlutterI18n.translate(context, string)),
                      ))
                  .toList(),
              onSelected: (_) async => await FlutterWebBrowser.openWebPage(
                    url: _ship.url,
                    androidToolbarColor: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: <Widget>[
              _shipCard(context),
              Separator.cardSpacer(),
              _specsCard(context),
              Separator.cardSpacer(),
              _missionsCard(context),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _shipCard(BuildContext context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.description.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
            context,
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.description.home_port',
            ),
            _ship.homePort),
        Separator.spacer(),
        RowItem.textRow(
            context,
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.description.built_date',
            ),
            _ship.getBuiltFullDate),
        _ship.hasExtras
            ? Column(children: <Widget>[
                Separator.divider(),
                _ship.isLandable
                    ? RowItem.textRow(
                        context,
                        FlutterI18n.translate(
                          context,
                          'spacex.vehicle.ship.description.landings_successful',
                        ),
                        _ship.getSuccessfulLandings,
                      )
                    : RowItem.textRow(
                        context,
                        FlutterI18n.translate(
                          context,
                          'spacex.vehicle.ship.description.catches_successful',
                        ),
                        _ship.getSuccessfulCatches,
                      ),
              ])
            : Separator.none()
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.specifications.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.feature',
          ),
          _ship.use,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.model',
          ),
          _ship.getModel(context),
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.role_primary',
          ),
          _ship.primaryRole,
        ),
        Separator.spacer(),
        _ship.hasSeveralRoles
            ? Column(children: <Widget>[
                RowItem.textRow(
                  context,
                  FlutterI18n.translate(
                    context,
                    'spacex.vehicle.ship.specifications.role_secondary',
                  ),
                  _ship.secondaryRole,
                ),
                Separator.spacer(),
              ])
            : Separator.none(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.status',
          ),
          _ship.getStatus(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.coordinates',
          ),
          _ship.getCoordinates(context),
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.mass',
          ),
          _ship.getMass(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
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
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.ship.missions.title',
      ),
      body: _ship.hasMissions
          ? Column(
              children: _ship.missions
                  .map((mission) => _getMission(
                        context,
                        _ship.missions,
                        mission,
                      ))
                  .toList(),
            )
          : Text(
              FlutterI18n.translate(
                context,
                'spacex.vehicle.ship.missions.no_missions',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
    );
  }

  Column _getMission(BuildContext context, List missions, mission) {
    return Column(children: <Widget>[
      RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.missions.mission',
            {'number': mission.id.toString()},
          ),
          mission.name),
      mission != missions.last ? Separator.spacer() : Separator.none()
    ]);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../models/info_ship.dart';
import '../util/colors.dart';
import '../widgets/card_page.dart';
import '../widgets/row_item.dart';
import '../widgets/separator.dart';

/// SHIP PAGE VIEW
/// This view all information about a specific ship. It displays Ship's specs.
class ShipPage extends StatelessWidget {
  final ShipInfo _ship;

  ShipPage(this._ship);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.3,
          floating: false,
          pinned: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.public),
              onPressed: () async => await FlutterWebBrowser.openWebPage(
                    url: _ship.url,
                    androidToolbarColor: primaryColor,
                  ),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.menu.marine_traffic',
              ),
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(_ship.name),
            background: InkWell(
              onTap: () async => await FlutterWebBrowser.openWebPage(
                    url: _ship.getProfilePhoto,
                    androidToolbarColor: primaryColor,
                  ),
              child: Hero(
                tag: _ship.id,
                child: CachedNetworkImage(
                  imageUrl: _ship.getProfilePhoto,
                  errorWidget: const Icon(Icons.error),
                  fadeInDuration: Duration(milliseconds: 100),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
            FlutterI18n.translate(
              context,
              'spacex.vehicle.ship.description.home_port',
            ),
            _ship.homePort),
        Separator.spacer(),
        RowItem.textRow(
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
                        FlutterI18n.translate(
                          context,
                          'spacex.vehicle.ship.description.landings_successful',
                        ),
                        _ship.getSuccessfulLandings,
                      )
                    : RowItem.textRow(
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
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.feature',
          ),
          _ship.use,
        ),
        Separator.spacer(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.model',
          ),
          _ship.getModel(context),
        ),
        Separator.divider(),
        RowItem.textRow(
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
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.status',
          ),
          _ship.getStatus(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.coordinates',
          ),
          _ship.getCoordinates(context),
        ),
        Separator.divider(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.ship.specifications.mass',
          ),
          _ship.getMass(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
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
              style: TextStyle(fontSize: 15.0, color: secondaryText),
            ),
    );
  }

  Column _getMission(BuildContext context, List missions, mission) {
    return Column(children: <Widget>[
      RowItem.textRow(
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

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:share/share.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../models/info_roadster.dart';
import '../../repositories/vehicles.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../widgets/index.dart';

/// Displays live information about Elon Musk's Tesla Roadster.
class RoadsterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoadsterInfo _roadster = context.read<VehiclesRepository>().roadster;
    return Scaffold(
      body: SliverFab(
        floatingWidget: SafeArea(
          top: false,
          bottom: false,
          left: false,
          child: FloatingActionButton(
            heroTag: null,
            tooltip: FlutterI18n.translate(
              context,
              'spacex.other.tooltip.watch_replay',
            ),
            onPressed: () => FlutterWebBrowser.openWebPage(
              url: _roadster.video,
              androidToolbarColor: Theme.of(context).primaryColor,
            ),
            child: Icon(Icons.ondemand_video),
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        slivers: <Widget>[
          SliverBar(
            title: _roadster.name,
            header: SwiperHeader(
              list: _roadster.photos,
              builder: (context, index) {
                final CacheImage photo = CacheImage(_roadster.getPhoto(index));
                return index == 0
                    ? Hero(
                        tag: '${_roadster.id}${_roadster.getPhoto(index)}',
                        child: photo,
                      )
                    : photo;
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => Share.share(
                  FlutterI18n.translate(
                    context,
                    'spacex.other.share.roadster',
                    translationParams: {
                      'date': _roadster.getLaunchDate(context),
                      'speed': _roadster.getSpeed,
                      'earth_distance': _roadster.getEarthDistance,
                      'details': Url.shareDetails
                    },
                  ),
                ),
                tooltip:
                    FlutterI18n.translate(context, 'spacex.other.menu.share'),
              ),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  for (final item in Menu.wikipedia)
                    PopupMenuItem(
                      value: item,
                      child: Text(FlutterI18n.translate(context, item)),
                    )
                ],
                onSelected: (text) => FlutterWebBrowser.openWebPage(
                  url: _roadster.url,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.cards(children: <Widget>[
                _roadsterCard(context),
                _vehicleCard(context),
                _orbitCard(context),
                _refreshLabel(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roadsterCard(BuildContext context) {
    final RoadsterInfo _roadster = context.read<VehiclesRepository>().roadster;
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.description.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.description.launch_date',
          ),
          _roadster.getFullFirstFlight,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.description.launch_vehicle',
          ),
          'Falcon Heavy',
        ),
        Separator.divider(),
        TextExpand(_roadster.description)
      ]),
    );
  }

  Widget _vehicleCard(BuildContext context) {
    final RoadsterInfo _roadster = context.read<VehiclesRepository>().roadster;
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.vehicle.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.mass',
          ),
          _roadster.getMass(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.speed',
          ),
          _roadster.getSpeed,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.distance_earth',
          ),
          _roadster.getEarthDistance,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.distance_mars',
          ),
          _roadster.getMarsDistance,
        ),
      ]),
    );
  }

  Widget _orbitCard(BuildContext context) {
    final RoadsterInfo _roadster = context.read<VehiclesRepository>().roadster;
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.orbit.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.type',
          ),
          _roadster.getOrbit,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.period',
          ),
          _roadster.getPeriod(context),
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.inclination',
          ),
          _roadster.getInclination,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.longitude',
          ),
          _roadster.getLongitude,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.apoapsis',
          ),
          _roadster.getApoapsis,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.periapsis',
          ),
          _roadster.getPeriapsis,
        ),
      ]),
    );
  }

  Widget _refreshLabel(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.refresh,
          size: 18,
          color: Theme.of(context).textTheme.caption.color,
        ),
        Separator.smallSpacer(),
        Text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.data_updated',
          ),
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).textTheme.caption.color,
          ),
        )
      ],
    );
  }
}

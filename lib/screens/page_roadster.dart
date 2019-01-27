import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../models/info_roadster.dart';
import '../util/colors.dart';
import '../widgets/cache_image.dart';
import '../widgets/card_page.dart';
import '../widgets/row_item.dart';
import '../widgets/separator.dart';

/// ROADSTER PAGE VIEW
/// Displays live information about Elon Musk's Tesla Roadster.
class RoadsterPage extends StatelessWidget {
  final RoadsterInfo _roadster;
  static final List<String> _menu = [
    'spacex.other.menu.wikipedia',
  ];

  RoadsterPage(this._roadster);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SliverFab(
              floatingWidget: FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                tooltip: FlutterI18n.translate(
                  context,
                  'spacex.other.tooltip.watch_replay',
                ),
                onPressed: () async => await FlutterWebBrowser.openWebPage(
                      url: _roadster.video,
                      androidToolbarColor: primaryColor,
                    ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  floating: false,
                  pinned: true,
                  actions: <Widget>[
                    PopupMenuButton<String>(
                      itemBuilder: (_) => _menu
                          .map((string) => PopupMenuItem(
                                value: string,
                                child: Text(
                                  FlutterI18n.translate(context, string),
                                ),
                              ))
                          .toList(),
                      onSelected: (_) async =>
                          await FlutterWebBrowser.openWebPage(
                            url: _roadster.url,
                            androidToolbarColor: primaryColor,
                          ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(_roadster.name),
                    background: Swiper(
                      itemCount: _roadster.getPhotosCount,
                      itemBuilder: (_, index) {
                        final CacheImage photo = CacheImage(
                          _roadster.getPhoto(index),
                        );
                        return index == 0
                            ? Hero(tag: _roadster.id, child: photo)
                            : photo;
                      },
                      autoplay: true,
                      autoplayDelay: 6000,
                      duration: 750,
                      onTap: (index) async =>
                          await FlutterWebBrowser.openWebPage(
                            url: _roadster.getPhoto(index),
                            androidToolbarColor: primaryColor,
                          ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      _roadsterCard(context),
                      Separator.cardSpacer(),
                      _vehicleCard(context),
                      Separator.cardSpacer(),
                      _orbitCard(context),
                      Separator.cardSpacer(),
                      Text(
                        FlutterI18n.translate(
                          context,
                          'spacex.vehicle.roadster.data_updated',
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: secondaryText),
                      )
                    ]),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _roadsterCard(BuildContext context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.description.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.description.launch_date',
          ),
          _roadster.getFullFirstFlight,
        ),
        Separator.spacer(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.description.launch_vehicle',
          ),
          'Falcon Heavy',
        ),
        Separator.divider(),
        Text(
          _roadster.description,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15.0, color: secondaryText),
        )
      ]),
    );
  }

  Widget _vehicleCard(BuildContext context) {
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.vehicle.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.mass',
          ),
          _roadster.getMass(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.speed',
          ),
          _roadster.getSpeed,
        ),
        Separator.divider(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.distance_earth',
          ),
          _roadster.getEarthDistance,
        ),
        Separator.spacer(),
        RowItem.textRow(
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
    return CardPage(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.roadster.orbit.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.type',
          ),
          _roadster.getOrbit,
        ),
        Separator.spacer(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.period',
          ),
          _roadster.getPeriod(context),
        ),
        Separator.divider(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.inclination',
          ),
          _roadster.getInclination,
        ),
        Separator.spacer(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.longitude',
          ),
          _roadster.getLongitude,
        ),
        Separator.divider(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.apoapsis',
          ),
          _roadster.getApoapsis,
        ),
        Separator.spacer(),
        RowItem.textRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.periapsis',
          ),
          _roadster.getPeriapsis,
        ),
      ]),
    );
  }
}

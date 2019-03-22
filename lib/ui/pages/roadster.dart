import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:share/share.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../models/info_roadster.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../../widgets/cache_image.dart';
import '../../widgets/card_page.dart';
import '../../widgets/expand_widget.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/row_item.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';

/// ROADSTER PAGE VIEW
/// Displays live information about Elon Musk's Tesla Roadster.
class RoadsterPage extends StatelessWidget {
  final RoadsterInfo _roadster;

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
                      androidToolbarColor: Theme.of(context).primaryColor,
                    ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              slivers: <Widget>[
                SliverBar(
                  title: Text(_roadster.name),
                  header: SwiperHeader(
                    list: _roadster.photos,
                    builder: (_, index) {
                      final CacheImage photo = CacheImage(
                        _roadster.getPhoto(index),
                      );
                      return index == 0
                          ? Hero(tag: _roadster.id, child: photo)
                          : photo;
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () => Share.share(
                            FlutterI18n.translate(
                              context,
                              'spacex.other.share.roadster',
                              {
                                'date': _roadster.getLaunchDate(context),
                                'speed': _roadster.getSpeed,
                                'earth_distance': _roadster.getEarthDistance,
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
                      itemBuilder: (_) => Menu.wikipedia
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
                            androidToolbarColor: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
                        style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Theme.of(context).textTheme.caption.color,
                            ),
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
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.description.launch_date',
          ),
          _roadster.getFullFirstFlight,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.description.launch_vehicle',
          ),
          'Falcon Heavy',
        ),
        Separator.divider(),
        TextExpand(text: _roadster.description, maxLength: 7)
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
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.mass',
          ),
          _roadster.getMass(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.speed',
          ),
          _roadster.getSpeed,
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.vehicle.distance_earth',
          ),
          _roadster.getEarthDistance,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
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
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.type',
          ),
          _roadster.getOrbit,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.period',
          ),
          _roadster.getPeriod(context),
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.inclination',
          ),
          _roadster.getInclination,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.longitude',
          ),
          _roadster.getLongitude,
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.roadster.orbit.apoapsis',
          ),
          _roadster.getApoapsis,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
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

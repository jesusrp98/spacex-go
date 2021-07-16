import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../../cubits/index.dart';
import '../../../models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// Displays live information about Elon Musk's Tesla Roadster.
class RoadsterPage extends StatelessWidget {
  final String id;

  const RoadsterPage(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoadsterVehicle _roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: SliverFab(
        floatingWidget: SafeArea(
          top: false,
          bottom: false,
          left: false,
          child: FloatingActionButton(
            heroTag: null,
            tooltip: context.translate('spacex.other.tooltip.watch_replay'),
            onPressed: () => context.openUrl(_roadster.url),
            child: Icon(Icons.ondemand_video),
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        slivers: <Widget>[
          SliverBar(
            title: _roadster.name,
            header: SwiperHeader(
              list: _roadster.photos,
              builder: (_, index) => CacheImage(_roadster.getPhoto(index)),
            ),
            actions: <Widget>[
              IconButton(
                icon: IconShadow(Icons.adaptive.share),
                onPressed: () => Share.share(
                  context.translate(
                    'spacex.other.share.roadster',
                    parameters: {
                      'date': _roadster.getLaunchDate(context),
                      'speed': _roadster.getSpeed,
                      'earth_distance': _roadster.getEarthDistance,
                      'details': Url.shareDetails
                    },
                  ),
                ),
                tooltip: context.translate('spacex.other.menu.share'),
              ),
            ],
            menuItemBuilder: (context) => [
              for (final item in Menu.wikipedia)
                PopupMenuItem(
                  value: item,
                  child: Text(context.translate(item)),
                )
            ],
            onMenuItemSelected: (text) => context.openUrl(_roadster.url),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.cards(children: <Widget>[
                _roadsterCard(context),
                _vehicleCard(context),
                _orbitCard(context),
                ItemCell(
                  icon: Icons.refresh,
                  text: context.translate(
                    'spacex.vehicle.roadster.data_updated',
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roadsterCard(BuildContext context) {
    final RoadsterVehicle _roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.roadster.description.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.roadster.description.launch_date'),
          _roadster.getFullFirstFlight,
        ),
        RowItem.text(
          context.translate(
            'spacex.vehicle.roadster.description.launch_vehicle',
          ),
          'Falcon Heavy',
        ),
        Separator.divider(),
        ExpandText(_roadster.description)
      ]),
    );
  }

  Widget _vehicleCard(BuildContext context) {
    final RoadsterVehicle _roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.roadster.vehicle.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.mass'),
          _roadster.getMass(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.speed'),
          _roadster.getSpeed,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.distance_earth'),
          _roadster.getEarthDistance,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.distance_mars'),
          _roadster.getMarsDistance,
        ),
      ]),
    );
  }

  Widget _orbitCard(BuildContext context) {
    final RoadsterVehicle _roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.roadster.orbit.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.type'),
          _roadster.getOrbit,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.period'),
          _roadster.getPeriod(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.inclination'),
          _roadster.getInclination,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.longitude'),
          _roadster.getLongitude,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.apoapsis'),
          _roadster.getApoapsis,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.periapsis'),
          _roadster.getPeriapsis,
        ),
      ]),
    );
  }
}

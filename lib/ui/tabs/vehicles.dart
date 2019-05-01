import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/info_vehicle.dart';
import '../../util/menu.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/hero_image.dart';
import '../../widgets/list_cell.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';
import '../pages/dragon.dart';
import '../pages/roadster.dart';
import '../pages/rocket.dart';
import '../pages/ship.dart';
import '../search/vehicles.dart';

/// VEHICLES TAB VIEW
/// This tab holds information about all kind of SpaceX's vehicles,
/// such as rockets, capsules, Tesla Roadster & ships.
class VehiclesTab extends StatelessWidget {
  Future<Null> _onRefresh(VehiclesModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((context) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) => Scaffold(
            body: RefreshIndicator(
              onRefresh: () => _onRefresh(model),
              child: CustomScrollView(
                  key: PageStorageKey('spacex_vehicles'),
                  slivers: <Widget>[
                    SliverBar(
                      title: FlutterI18n.translate(
                        context,
                        'spacex.vehicle.title',
                      ),
                      header: model.isLoading
                          ? LoadingIndicator()
                          : SwiperHeader(list: model.photos),
                      actions: <Widget>[
                        PopupMenuButton<String>(
                          itemBuilder: (context) => Menu.home.keys
                              .map((string) => PopupMenuItem(
                                    value: string,
                                    child: Text(
                                      FlutterI18n.translate(context, string),
                                    ),
                                  ))
                              .toList(),
                          onSelected: (string) => Navigator.pushNamed(
                                context,
                                Menu.home[string],
                              ),
                        ),
                      ],
                    ),
                    model.isLoading
                        ? SliverFillRemaining(child: LoadingIndicator())
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              _buildVehicle,
                              childCount: model.getItemCount,
                            ),
                          ),
                  ]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.search),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.search',
              ),
              onPressed: () => Navigator.of(context).push(
                    searchVehicles(context, model.items),
                  ),
            ),
          ),
    );
  }

  Widget _buildVehicle(BuildContext context, int index) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) {
        final Vehicle vehicle = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: HeroImage.list(
                url: vehicle.getProfilePhoto,
                tag: vehicle.id,
              ),
            ),
            title: vehicle.name,
            subtitle: vehicle.subtitle(context),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => vehicle.type == 'rocket'
                        ? RocketPage(vehicle)
                        : vehicle.type == 'capsule'
                            ? DragonPage(vehicle)
                            : vehicle.type == 'ship'
                                ? ShipPage(vehicle)
                                : RoadsterPage(vehicle),
                  ),
                ),
          ),
          Separator.thinDivider(indent: 81)
        ]);
      },
    );
  }
}

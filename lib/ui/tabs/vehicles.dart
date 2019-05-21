import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/info_vehicle.dart';
import '../../widgets/hero_image.dart';
import '../../widgets/list_cell.dart';
import '../../widgets/scroll_page.dart';
import '../pages/dragon.dart';
import '../pages/roadster.dart';
import '../pages/rocket.dart';
import '../pages/ship.dart';
import '../search/vehicles.dart';

/// VEHICLES TAB VIEW
/// This tab holds information about all kind of SpaceX's vehicles,
/// such as rockets, capsules, Tesla Roadster & ships.
class VehiclesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) => Scaffold(
            body: ScrollPage<VehiclesModel>.tab(
              context: context,
              photos: model.photos,
              title: FlutterI18n.translate(context, 'spacex.vehicle.title'),
              children: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    _buildVehicle,
                    childCount: model.getItemCount,
                  ),
                ),
              ],
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
          Separator.divider(indent: 81)
        ]);
      },
    );
  }
}

import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:search_page/search_page.dart';

import '../../models/index.dart';
import '../../repositories/index.dart';
import '../../util/menu.dart';
import '../pages/index.dart';
import '../widgets/index.dart';

/// This tab holds information about all kind of SpaceX's vehicles,
/// such as rockets, capsules, Tesla Roadster & ships.
class VehiclesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VehiclesRepository>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<VehiclesRepository>.slide(
          title: FlutterI18n.translate(context, 'spacex.vehicle.title'),
          slides: model.photos,
          popupMenu: Menu.home,
          body: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                _buildVehicle,
                childCount: model.vehicles.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          tooltip: FlutterI18n.translate(
            context,
            'spacex.other.tooltip.search',
          ),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchPage<VehicleInfo>(
              items: model.vehicles,
              searchLabel: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.search',
              ),
              suggestion: BigTip(
                icon: Icons.search,
                message: FlutterI18n.translate(
                  context,
                  'spacex.search.suggestion.vehicle',
                ),
              ),
              failure: BigTip(
                icon: Icons.sentiment_dissatisfied,
                message: FlutterI18n.translate(
                  context,
                  'spacex.search.failure',
                ),
              ),
              filter: (vehicle) => [
                vehicle.name,
                vehicle.year,
              ],
              builder: (vehicle) => Column(
                children: <Widget>[
                  ListCell(
                    title: vehicle.name,
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _vehiclePage(vehicle),
                      ),
                    ),
                  ),
                  Separator.divider(indent: 16)
                ],
              ),
            ),
          ),
          child: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildVehicle(BuildContext context, int index) {
    return Consumer<VehiclesRepository>(
      builder: (context, model, child) {
        final VehicleInfo vehicle = model.vehicles[index];
        return Column(children: <Widget>[
          ListCell(
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                builder: (context) => _vehiclePage(vehicle),
              ),
            ),
          ),
          Separator.divider(indent: 75)
        ]);
      },
    );
  }

  Widget _vehiclePage(VehicleInfo vehicle) {
    switch (vehicle.type) {
      case 'rocket':
        return RocketPage(vehicle);
        break;
      case 'capsule':
        return DragonPage(vehicle);
        break;
      case 'ship':
        return ShipPage(vehicle);
        break;
      default:
        return RoadsterPage(vehicle);
    }
  }
}

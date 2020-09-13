import 'package:big_tip/big_tip.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:search_page/search_page.dart';

import '../../models/index.dart';
import '../../repositories/index.dart';
import '../../util/index.dart';
import '../pages/vehicle/vehicle.dart';
import '../widgets/index.dart';

/// This tab holds information about all kind of SpaceX's vehicles,
/// such as rockets, capsules, Tesla Roadster & ships.
class VehiclesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VehiclesRepository>(
      builder: (context, model, child) => Scaffold(
        body: ReloadableSliverPage<VehiclesRepository>.slide(
          title: FlutterI18n.translate(context, 'spacex.vehicle.title'),
          slides: model.photos,
          popupMenu: Menu.home,
          body: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                _buildVehicle,
                childCount: model.vehicles?.length,
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
            delegate: SearchPage<Vehicle>(
              items: model.vehicles,
              searchLabel: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.search',
              ),
              suggestion: BigTip(
                title: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.vehicle.title',
                  ),
                  style: GoogleFonts.rubikTextTheme(
                    Theme.of(context).textTheme,
                  ).headline6,
                ),
                subtitle: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.search.suggestion.vehicle',
                  ),
                  style: GoogleFonts.rubikTextTheme(
                    Theme.of(context).textTheme,
                  ).subtitle1.copyWith(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                ),
                child: Icon(Icons.search),
              ),
              failure: BigTip(
                title: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.vehicle.title',
                  ),
                  style: GoogleFonts.rubikTextTheme(
                    Theme.of(context).textTheme,
                  ).headline6,
                ),
                subtitle: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.search.failure',
                  ),
                  style: GoogleFonts.rubikTextTheme(
                    Theme.of(context).textTheme,
                  ).subtitle1.copyWith(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                ),
                child: Icon(Icons.sentiment_dissatisfied),
              ),
              filter: (vehicle) => [
                vehicle.name,
                vehicle.year,
              ],
              builder: (vehicle) => Column(
                children: <Widget>[
                  ListCell(
                    title: vehicle.name,
                    onTap: () => Navigator.pushNamed(
                      context,
                      VehiclePage.route,
                      arguments: {'id': vehicle.id},
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
        final vehicle = model.vehicles[index];
        return Column(children: <Widget>[
          ListCell(
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: ProfileImage.small(vehicle.getProfilePhoto),
            ),
            title: vehicle.name,
            subtitle: vehicle.subtitle(context),
            onTap: () => Navigator.pushNamed(
              context,
              VehiclePage.route,
              arguments: {'id': vehicle.id},
            ),
          ),
          Separator.divider(indent: 72)
        ]);
      },
    );
  }
}

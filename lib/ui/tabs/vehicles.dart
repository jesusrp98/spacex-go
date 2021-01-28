import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:search_page/search_page.dart';

import '../../cubits/index.dart';
import '../../models/index.dart';
import '../../util/index.dart';
import '../widgets/custom_page_cubit.dart' as c;
import '../widgets/index.dart';

/// This tab holds information about all kind of SpaceX's vehicles,
/// such as rockets, capsules, Tesla Roadster & ships.
class VehiclesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: c.RequestSliverPage<VehiclesCubit, List<Vehicle>>(
        title: FlutterI18n.translate(context, 'spacex.vehicle.title'),
        headerBuilder: (context, state, value) {
          final photos = [
            for (final vehicle in value) vehicle.getRandomPhoto()
          ];

          return SwiperHeader(list: photos.sublist(0, 4));
        },
        popupMenu: Menu.home,
        childrenBuilder: (context, state, value) => [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => VehicleCell(value[index]),
              childCount: value.length,
            ),
          ),
        ],
      ),
      floatingActionButton: RequestBuilder<VehiclesCubit, List<Vehicle>>(
        onLoaded: (context, state, value) => FloatingActionButton(
          heroTag: null,
          tooltip: FlutterI18n.translate(
            context,
            'spacex.other.tooltip.search',
          ),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchPage<Vehicle>(
              items: value,
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
                  // style: GoogleFonts.rubikTextTheme(
                  //   Theme.of(context).textTheme,
                  // ).headline6,
                ),
                subtitle: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.search.suggestion.vehicle',
                  ),
                  // style: GoogleFonts.rubikTextTheme(
                  //   Theme.of(context).textTheme,
                  // ).subtitle1.copyWith(
                  //       color:
                  //           Theme.of(context).textTheme.caption.color,
                  //     ),
                ),
                child: Icon(Icons.search),
              ),
              failure: BigTip(
                title: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.vehicle.title',
                  ),
                  // style: GoogleFonts.rubikTextTheme(
                  //   Theme.of(context).textTheme,
                  // ).headline6,
                ),
                subtitle: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.search.failure',
                  ),
                  // style: GoogleFonts.rubikTextTheme(
                  //   Theme.of(context).textTheme,
                  // ).subtitle1.copyWith(
                  //       color:
                  //           Theme.of(context).textTheme.caption.color,
                  //     ),
                ),
                child: Icon(Icons.sentiment_dissatisfied),
              ),
              filter: (vehicle) => [
                vehicle.name,
                vehicle.year,
                vehicle.type,
              ],
              builder: (vehicle) => VehicleCell(vehicle),
            ),
          ),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}

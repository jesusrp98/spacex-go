import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';

import '../../../cubits/index.dart';
import '../../widgets/index.dart';
import 'index.dart';

/// This view displays information about a specific crew member, that flies on
/// a SpaceX or NASA mission.
class CrewPage extends StatelessWidget {
  final String launchId;
  final String crewId;

  const CrewPage({
    Key key,
    this.launchId,
    this.crewId,
  }) : super(key: key);

  static const route = '/crew';

  @override
  Widget build(BuildContext context) {
    final crew = context
        .watch<LaunchesCubit>()
        .getLaunch(launchId)
        .rocket
        .getCrew(crewId);

    return Scaffold(
      body: SliverPage(
        title: crew.name,
        header: CacheImage(crew.imageUrl),
        children: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.body(children: <Widget>[
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.crew.agency',
                  ),
                  crew.agency,
                ),
                RowItem.text(
                  FlutterI18n.translate(
                    context,
                    'spacex.dialog.crew.status',
                  ),
                  crew.getStatus,
                ),
                if (crew.hasMissions) ...[
                  Separator.divider(),
                  for (final launch in crew.launches)
                    RowTap(
                      FlutterI18n.translate(
                        context,
                        'spacex.dialog.vehicle.mission',
                        translationParams: {
                          'number': launch.flightNumber.toString()
                        },
                      ),
                      launch.name,
                      onTap: () => Navigator.pushNamed(
                        context,
                        LaunchPage.route,
                        arguments: {'id': launch.id},
                      ),
                    ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

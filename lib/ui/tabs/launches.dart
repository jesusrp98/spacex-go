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
import '../widgets/index.dart';

/// This tab holds information a specific type of launches,
/// upcoming or latest, defined by the model.
class LaunchesTab extends StatelessWidget {
  final LaunchType type;

  const LaunchesTab(this.type);

  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchesRepository>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<LaunchesRepository>.slide(
          title: FlutterI18n.translate(
            context,
            type == LaunchType.upcoming
                ? 'spacex.upcoming.title'
                : 'spacex.latest.title',
          ),
          slides: List.from(
            model.isLoaded ? model.getPhotos(type) : [],
          )..shuffle(),
          popupMenu: Menu.home,
          body: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                _buildLaunch,
                childCount: model.getLaunchesCount(type),
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
            delegate: SearchPage<Launch>(
              items: model.getLaunches(type),
              searchLabel: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.search',
              ),
              suggestion: BigTip(
                title: Text(
                  FlutterI18n.translate(
                    context,
                    type == LaunchType.upcoming
                        ? 'spacex.upcoming.title'
                        : 'spacex.latest.title',
                  ),
                  style: GoogleFonts.rubikTextTheme(
                    Theme.of(context).textTheme,
                  ).headline6,
                ),
                subtitle: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.search.suggestion.launch',
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
                    type == LaunchType.upcoming
                        ? 'spacex.upcoming.title'
                        : 'spacex.latest.title',
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
              filter: (launch) => [
                launch.rocket.name,
                launch.name,
                launch.flightNumber.toString(),
                launch.year,
              ],
              builder: (launch) => Column(
                children: <Widget>[
                  ListCell(
                    title: launch.name,
                    trailing: TrailingText(launch.getNumber),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.launch,
                      arguments: {'id': launch.id},
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

  Widget _buildLaunch(BuildContext context, int index) {
    return Consumer<LaunchesRepository>(
      builder: (context, model, child) {
        final launch = model.getLaunches(type)[index];
        return Column(children: <Widget>[
          ListCell(
            leading: ProfileImage.small(launch.patchUrl),
            title: launch.name,
            subtitle: launch.getLaunchDate(context),
            trailing: TrailingText(launch.getNumber),
            onTap: () => Navigator.pushNamed(
              context,
              Routes.launch,
              arguments: {'id': launch.id},
            ),
          ),
          Separator.divider(indent: 72)
        ]);
      },
    );
  }
}

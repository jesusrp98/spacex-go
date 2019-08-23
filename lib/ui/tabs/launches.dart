import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/models/index.dart';
import '../../util/menu.dart';
import '../pages/index.dart';
import '../search/index.dart';
import '../widgets/index.dart';

/// This tab holds information a specific type of launches,
/// upcoming or latest, defined by the model.
class LaunchesTab extends StatelessWidget {
  final Launches type;

  LaunchesTab(this.type);

  @override
  Widget build(BuildContext context) {
    return Consumer<LaunchesModel>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<LaunchesModel>.slide(
          title: FlutterI18n.translate(
            context,
            type == Launches.upcoming
                ? 'spacex.upcoming.title'
                : 'spacex.latest.title',
          ),
          slides: model.photos,
          popupMenu: Menu.home,
          body: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                _buildLaunch,
                childCount: model.getItemCount,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.search),
          tooltip: FlutterI18n.translate(
            context,
            'spacex.other.tooltip.search',
          ),
          onPressed: () => Navigator.of(context).push(
            searchLaunches(context, model.items),
          ),
        ),
      ),
    );
  }

  Widget _buildLaunch(BuildContext context, int index) {
    return Consumer<LaunchesModel>(
      builder: (context, model, child) {
        final Launch launch = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: HeroImage.list(
              url: launch.getPatchUrl,
              tag: launch.getNumber,
            ),
            title: launch.name,
            subtitle: launch.getLaunchDate(context),
            trailing: MissionNumber(launch.getNumber),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LaunchPage(launch)),
            ),
          ),
          Separator.divider(indent: 81)
        ]);
      },
    );
  }
}

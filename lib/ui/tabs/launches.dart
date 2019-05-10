import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/launch.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/hero_image.dart';
import '../../widgets/list_cell.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';
import '../pages/launch.dart';
import '../search/launches.dart';
import 'package:connectivity/connectivity.dart';

/// LAUNCHES TAB VIEW
/// This tab holds information a specific type of launches,
/// upcoming or latest, defined by the model.
class LaunchesTab extends StatelessWidget {
  final int title;

  LaunchesTab(this.title);

  Future<Null> _onRefresh(LaunchesModel model, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    Completer<Null> completer = Completer<Null>();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("Connected to a network");
      model.refresh().then((_) => completer.complete());
    } else {
      print("Unable to connect. Please Check Internet Connection");

      completer.complete();
      //snackbar informing no connectivity
      final snackBar = SnackBar(
          content: Text('No internet connection, cannot reload.'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              // Some code to undo the change!
            },
          ));
      Scaffold.of(context).showSnackBar(snackBar);
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LaunchesModel>(
      builder: (context, child, model) => Scaffold(
            body: RefreshIndicator(
              onRefresh: () => _onRefresh(model, context),
              child: CustomScrollView(
                  key: PageStorageKey('spacex_launches_$title'),
                  slivers: <Widget>[
                    SliverBar(
                      title: Text(FlutterI18n.translate(
                        context,
                        title == 0
                            ? 'spacex.upcoming.title'
                            : 'spacex.latest.title',
                      )),
                      header: model.isLoading
                          ? LoadingIndicator()
                          : SwiperHeader(list: model.photos),
                    ),
                    model.isLoading
                        ? SliverFillRemaining(child: LoadingIndicator())
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              _buildLaunch,
                              childCount: model.getItemCount,
                            ),
                          ),
                  ]),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.search),
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
    return ScopedModelDescendant<LaunchesModel>(
      builder: (context, child, model) {
        final Launch launch = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: HeroImage.list(
              url: launch.getImageUrl,
              tag: launch.getNumber,
            ),
            title: launch.name,
            subtitle: launch.getLaunchDate(context),
            trailing: MissionNumber(launch.getNumber),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LaunchPage(launch)),
                ),
          ),
          Separator.divider(height: 0, indent: 88)
        ]);
      },
    );
  }
}

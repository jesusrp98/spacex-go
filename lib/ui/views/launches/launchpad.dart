import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';

import '../../../cubits/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// This view displays information about a specific launchpad,
/// where rockets get rocketed to the sky...
class LaunchpadPage extends StatelessWidget {
  final String launchId;

  const LaunchpadPage({Key key, this.launchId}) : super(key: key);

  static const route = '/launchpad';

  @override
  Widget build(BuildContext context) {
    final launchpad =
        context.watch<LaunchesCubit>().getLaunch(launchId).launchpad;

    return Scaffold(
      body: SliverPage(
        title: launchpad.name,
        header: CacheImage(launchpad.imageUrl),
        children: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.body(children: <Widget>[
                Text(
                  launchpad.fullName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.status'),
                  launchpad.getStatus,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.location'),
                  launchpad.locality,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.state'),
                  launchpad.region,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.coordinates'),
                  launchpad.getCoordinates,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.launches_successful'),
                  launchpad.getSuccessfulLaunches,
                ),
                Separator.divider(),
                ExpandText(launchpad.details)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

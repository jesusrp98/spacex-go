import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';

import '../../../cubits/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// This view displays information about a specific landpad,
/// where rockets now land.
class LandpadPage extends StatelessWidget {
  final String launchId;
  final String coreId;

  const LandpadPage({
    Key key,
    this.launchId,
    this.coreId,
  }) : super(key: key);

  static const route = '/landpad';

  @override
  Widget build(BuildContext context) {
    final landpad = context
        .watch<LaunchesCubit>()
        .getLaunch(launchId)
        .rocket
        .getCore(coreId)
        .landpad;

    return Scaffold(
      body: SliverPage(
        title: landpad.name,
        header: CacheImage(landpad.imageUrl),
        children: <Widget>[
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.body(children: <Widget>[
                Text(
                  landpad.fullName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.status'),
                  landpad.getStatus,
                ),
                RowItem.text(context.translate('spacex.dialog.pad.location'),
                    landpad.locality),
                RowItem.text(
                  context.translate('spacex.dialog.pad.state'),
                  landpad.region,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.coordinates'),
                  landpad.getCoordinates,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.landing_type'),
                  landpad.type,
                ),
                RowItem.text(
                  context.translate('spacex.dialog.pad.landings_successful'),
                  landpad.getSuccessfulLandings,
                ),
                Separator.divider(),
                ExpandText(landpad.details)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

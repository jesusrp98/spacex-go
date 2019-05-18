import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/launchpad.dart';
import '../../widgets/expand_widget.dart';
import '../../widgets/header_map.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/row_item.dart';
import '../../widgets/sliver_bar.dart';

/// LAUNCHPAD PAGE VIEW
/// This view displays information about a specific launchpad,
/// where rockets get rocketed to the sky...
class LaunchpadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LaunchpadModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverBar(
                title: model.name,
                header: model.isLoading
                    ? LoadingIndicator()
                    : MapHeader(model.launchpad.coordinates),
              ),
              model.isLoading
                  ? SliverFillRemaining(child: LoadingIndicator())
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<LaunchpadModel>(
      builder: (context, child, model) => RowLayout.body(children: <Widget>[
            Text(
              model.launchpad.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.pad.status',
              ),
              model.launchpad.getStatus,
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.pad.location',
              ),
              model.launchpad.location,
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.pad.state',
              ),
              model.launchpad.state,
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.pad.coordinates',
              ),
              model.launchpad.getCoordinates,
            ),
            RowText(
              FlutterI18n.translate(
                context,
                'spacex.dialog.pad.launches_successful',
              ),
              model.launchpad.getSuccessfulLaunches,
            ),
            Separator.divider(),
            TextExpand(text: model.launchpad.details, maxLength: 8)
          ]),
    );
  }
}

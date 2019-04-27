import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/landpad.dart';
import '../../widgets/expand_widget.dart';
import '../../widgets/header_map.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/row_item.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';

/// LANDPAD PAGE VIEW
/// This view displays information about a specific landpad,
/// where rockets now land.
class LandpadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LandpadModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverBar(
                title: Text(model.id),
                header: model.isLoading
                    ? LoadingIndicator()
                    : MapHeader(model.landpad.coordinates),
              ),
              model.isLoading
                  ? SliverFillRemaining(child: LoadingIndicator())
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<LandpadModel>(
      builder: (context, child, model) => Padding(
            padding: EdgeInsets.all(12),
            child: Column(children: <Widget>[
              Text(
                model.landpad.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.status',
                ),
                model.landpad.getStatus,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.location',
                ),
                model.landpad.location,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.state',
                ),
                model.landpad.state,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.coordinates',
                ),
                model.landpad.getCoordinates,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.landing_type',
                ),
                model.landpad.type,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.landings_successful',
                ),
                model.landpad.getSuccessfulLandings,
              ),
              Separator.divider(),
              TextExpand(text: model.landpad.details, maxLength: 8)
            ]),
          ),
    );
  }
}

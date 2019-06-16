import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/spacex_company.dart';
import '../../widgets/achievement_cell.dart';
import '../../widgets/header_text.dart';
import '../../widgets/row_item.dart';
import '../../widgets/scroll_page.dart';

/// COMPANY TAB VIEW
/// This tab holds information about SpaceX-as-a-company,
/// such as various numbers & achievements.
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SpacexCompanyModel>(
      builder: (context, child, model) => Scaffold(
            body: ScrollPage<SpacexCompanyModel>.tab(
              context: context,
              photos: model.photos,
              title: FlutterI18n.translate(context, 'spacex.company.title'),
              children: <Widget>[
                SliverToBoxAdapter(child: _buildBody()),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    _buildAchievement,
                    childCount: model.getItemCount,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<SpacexCompanyModel>(
      builder: (context, child, model) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RowLayout(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                children: <Widget>[
                  Text(
                    model.company.fullName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    model.company.getFounderDate(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.ceo',
                    ),
                    model.company.ceo,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.cto',
                    ),
                    model.company.cto,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.coo',
                    ),
                    model.company.coo,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.valuation',
                    ),
                    model.company.getValuation,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.location',
                    ),
                    model.company.getLocation,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.employees',
                    ),
                    model.company.getEmployees,
                  ),
                  Text(
                    model.company.details,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ],
              ),
              HeaderText(FlutterI18n.translate(
                context,
                'spacex.company.tab.achievements',
              ))
            ],
          ),
    );
  }

  Widget _buildAchievement(BuildContext context, int index) {
    return ScopedModelDescendant<SpacexCompanyModel>(
      builder: (context, child, model) {
        final Achievement achievement = model.getItem(index);
        return Column(
          children: <Widget>[
            AchievementCell(
              title: achievement.name,
              subtitle: achievement.getDate,
              body: achievement.details,
              url: achievement.url,
              index: index + 1,
            ),
            Separator.divider(indent: 68),
          ],
        );
      },
    );
  }
}

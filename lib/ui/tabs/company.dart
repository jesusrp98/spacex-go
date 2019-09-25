import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/models/index.dart';
import '../../util/menu.dart';
import '../widgets/index.dart';

/// This tab holds information about SpaceX-as-a-company,
/// such as various numbers & achievements.
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyModel>(
      builder: (context, model, child) => Scaffold(
        body: SliverPage<CompanyModel>.slide(
          title: FlutterI18n.translate(context, 'spacex.company.title'),
          slides: model.photos,
          popupMenu: Menu.home,
          body: <Widget>[
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
    return Consumer<CompanyModel>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowLayout(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            children: <Widget>[
              Text(
                model.company.fullName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'ProductSans',
                ),
              ),
              Text(
                model.company.getFounderDate(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'ProductSans',
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
    return Consumer<CompanyModel>(
      builder: (context, model, child) {
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

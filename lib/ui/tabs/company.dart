import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/spacex_company.dart';
import '../../util/menu.dart';
import '../../widgets/achievement_cell.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/header_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/row_item.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';

/// COMPANY TAB VIEW
/// This tab holds information about SpaceX-as-a-company,
/// such as various numbers & achievements.
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SpacexCompanyModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(
              key: PageStorageKey('spacex_company'),
              slivers: <Widget>[
                SliverBar(
                  title: FlutterI18n.translate(context, 'spacex.company.title'),
                  header: model.isLoading
                      ? LoadingIndicator()
                      : SwiperHeader(list: model.photos),
                  actions: <Widget>[
                    PopupMenuButton<String>(
                      itemBuilder: (context) => Menu.home.keys
                          .map((string) => PopupMenuItem(
                                value: string,
                                child: Text(
                                  FlutterI18n.translate(context, string),
                                ),
                              ))
                          .toList(),
                      onSelected: (string) => Navigator.pushNamed(
                            context,
                            Menu.home[string],
                          ),
                    ),
                  ],
                ),
                if (model.isLoading)
                  SliverFillRemaining(child: LoadingIndicator())
                else ...[
                  SliverToBoxAdapter(child: _buildBody()),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      _buildAchievement,
                      childCount: model.getItemCount,
                    ),
                  ),
                ]
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
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  children: <Widget>[
                    Text(
                      model.company.fullName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    Separator.spacer(),
                    Text(
                      model.company.getFounderDate(context),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                    ),
                    Separator.spacer(),
                    RowItem.textRow(
                      context,
                      FlutterI18n.translate(
                        context,
                        'spacex.company.tab.ceo',
                      ),
                      model.company.ceo,
                    ),
                    Separator.spacer(),
                    RowItem.textRow(
                      context,
                      FlutterI18n.translate(
                        context,
                        'spacex.company.tab.cto',
                      ),
                      model.company.cto,
                    ),
                    Separator.spacer(),
                    RowItem.textRow(
                      context,
                      FlutterI18n.translate(
                        context,
                        'spacex.company.tab.coo',
                      ),
                      model.company.coo,
                    ),
                    Separator.spacer(),
                    RowItem.textRow(
                      context,
                      FlutterI18n.translate(
                        context,
                        'spacex.company.tab.valuation',
                      ),
                      model.company.getValuation,
                    ),
                    Separator.spacer(),
                    RowItem.textRow(
                      context,
                      FlutterI18n.translate(
                        context,
                        'spacex.company.tab.location',
                      ),
                      model.company.getLocation,
                    ),
                    Separator.spacer(),
                    RowItem.textRow(
                      context,
                      FlutterI18n.translate(
                        context,
                        'spacex.company.tab.employees',
                      ),
                      model.company.getEmployees,
                    ),
                    Separator.spacer(),
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
            Separator.thinDivider(indent: 68),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/spacex_company.dart';
import '../../util/menu.dart';
import '../../widgets/achievement_cell.dart';
import '../../widgets/header_swiper.dart';
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
                  title: Text(
                    FlutterI18n.translate(context, 'spacex.company.title'),
                  ),
                  header: model.isLoading
                      ? LoadingIndicator()
                      : SwiperHeader(list: model.photos),
                  actions: <Widget>[
                    PopupMenuButton<String>(
                      itemBuilder: (context) => Menu.company
                          .map((url) => PopupMenuItem(
                                value: url,
                                child: Text(
                                  FlutterI18n.translate(context, url),
                                ),
                              ))
                          .toList(),
                      onSelected: (name) async =>
                          await FlutterWebBrowser.openWebPage(
                            url: model.company.getUrl(
                              Menu.company.indexOf(name),
                            ),
                            androidToolbarColor: Theme.of(context).primaryColor,
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Text(
                      model.company.fullName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Separator.spacer(),
                    Text(
                      model.company.getFounderDate(context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subhead.copyWith(
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
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                    ),
                  ],
                ),
              ),
              Separator.divider(height: 0)
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
            Separator.divider(height: 0, indent: 82),
          ],
        );
      },
    );
  }
}

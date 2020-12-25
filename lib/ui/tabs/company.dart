import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../repositories/index.dart';
import '../../util/index.dart';
import '../../util/menu.dart';
import '../../util/photos.dart';
import '../widgets/index.dart';

/// This tab holds information about SpaceX-as-a-company,
/// such as various numbers & achievements.
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyRepository>(
      builder: (context, model, child) =>
          ReloadableSliverPage<CompanyRepository>.slide(
        title: FlutterI18n.translate(context, 'spacex.company.title'),
        slides: List.from(SpaceXPhotos.company)..shuffle(),
        popupMenu: Menu.home,
        body: <Widget>[
          SliverToBoxAdapter(
            child: _buildBody(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              _buildAchievement,
              childCount: model.getAchievementsCount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<CompanyRepository>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            top: false,
            minimum: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: RowLayout(
              children: <Widget>[
                RowLayout(
                  space: 6,
                  children: <Widget>[
                    Text(
                      model.company.fullName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubikTextTheme(
                        Theme.of(context).textTheme,
                      ).subtitle1,
                    ),
                    Text(
                      model.company.getFounderDate(context),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubikTextTheme(
                        Theme.of(context).textTheme,
                      ).subtitle1.copyWith(
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                    ),
                  ],
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
                TextExpand(
                  model.company.details,
                ),
              ],
            ),
          ),
          HeaderText(
            FlutterI18n.translate(
              context,
              'spacex.company.tab.achievements',
            ),
            head: true,
          )
        ],
      ),
    );
  }

  Widget _buildAchievement(BuildContext context, int index) {
    return Consumer<CompanyRepository>(
      builder: (context, model, child) {
        final achievement = model.getAchievement(index);
        return Column(
          children: <Widget>[
            DetailsCell(
              leading: (index + 1).toString(),
              title: achievement.name,
              subtitle: achievement.getDate,
              body: achievement.details,
              onTap:
                  achievement.hasLink ? () => showUrl(achievement.url) : null,
            ),
            Separator.divider(indent: 16),
          ],
        );
      },
    );
  }
}

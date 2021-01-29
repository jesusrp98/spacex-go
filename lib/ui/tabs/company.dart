import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

import '../../cubits/index.dart';
import '../../models/index.dart';
import '../../util/index.dart';
import '../widgets/custom_page_cubit.dart' as c;
import '../widgets/index.dart';

/// This tab holds information about SpaceX-as-a-company,
/// such as various numbers & achievements.
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return c.SliverPage(
      title: FlutterI18n.translate(context, 'spacex.company.title'),
      header: SwiperHeader(list: List.from(SpaceXPhotos.company)..shuffle()),
      popupMenu: Menu.home,
      children: [
        _ComapnyInfoView(),
        _AchievementsListView(),
      ],
    );
  }
}

class _ComapnyInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RequestBuilder<CompanyCubit, CompanyInfo>(
        onLoaded: (context, state, value) => Column(
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
                        value.fullName,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubikTextTheme(
                          Theme.of(context).textTheme,
                        ).subtitle1,
                      ),
                      Text(
                        value.getFounderDate(context),
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
                    value.ceo,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.cto',
                    ),
                    value.cto,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.coo',
                    ),
                    value.coo,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.valuation',
                    ),
                    value.getValuation,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.location',
                    ),
                    value.getLocation,
                  ),
                  RowText(
                    FlutterI18n.translate(
                      context,
                      'spacex.company.tab.employees',
                    ),
                    value.getEmployees,
                  ),
                  TextExpand(
                    value.details,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText(
            FlutterI18n.translate(
              context,
              'spacex.company.tab.achievements',
            ),
            head: true,
          ),
          RequestBuilder<AchievementsCubit, List<Achievement>>(
            onLoaded: (context, state, value) => ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => AchievementCell(
                achievement: value[index],
                index: index,
              ),
              itemCount: value.length,
            ),
          ),
        ],
      ),
    );
  }
}

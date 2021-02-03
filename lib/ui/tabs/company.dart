import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:row_collection/row_collection.dart';

import '../../cubits/index.dart';
import '../../models/index.dart';
import '../../util/index.dart';
import '../widgets/index.dart';

/// This tab holds information about SpaceX-as-a-company,
/// such as various numbers & achievements.
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPage(
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
    return RequestBuilder<CompanyCubit, CompanyInfo>(
      onLoading: (context, state) => LoadingSliverView(),
      onLoaded: (context, state, value) => SliverToBoxAdapter(
        child: Column(
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
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        value.getFounderDate(context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
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
    return RequestBuilder<AchievementsCubit, List<Achievement>>(
      onLoading: (context, state) => LoadingSliverView(),
      onLoaded: (context, state, value) => SliverToBoxAdapter(
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
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => AchievementCell(
                achievement: value[index],
                index: index,
              ),
              itemCount: value.length,
            ),
          ],
        ),
      ),
    );
  }
}

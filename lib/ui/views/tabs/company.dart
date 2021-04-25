import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';

import '../../../cubits/index.dart';
import '../../../models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// This tab holds information about SpaceX-as-a-company,
/// such as various numbers & achievements.
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPage(
      title: context.translate('spacex.company.title'),
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
      onLoading: (context, state, value) => LoadingSliverView(),
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
                  RowItem.text(
                    context.translate('spacex.company.tab.ceo'),
                    value.ceo,
                  ),
                  RowItem.text(
                    context.translate('spacex.company.tab.cto'),
                    value.cto,
                  ),
                  RowItem.text(
                    context.translate('spacex.company.tab.coo'),
                    value.coo,
                  ),
                  RowItem.text(
                    context.translate('spacex.company.tab.valuation'),
                    value.getValuation,
                  ),
                  RowItem.text(
                    context.translate('spacex.company.tab.location'),
                    value.getLocation,
                  ),
                  RowItem.text(
                    context.translate('spacex.company.tab.employees'),
                    value.getEmployees,
                  ),
                  ExpandText(value.details),
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
      onLoading: (context, state, vale) => LoadingSliverView(),
      onLoaded: (context, state, value) => SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(
              context.translate('spacex.company.tab.achievements'),
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

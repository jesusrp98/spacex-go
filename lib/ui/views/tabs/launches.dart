import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:search_page/search_page.dart';

import '../../../cubits/index.dart';
import '../../../models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// Variable that determins the type of launches are shown within this view
enum LaunchType { upcoming, latest }

/// This tab holds information a specific type of launches,
/// upcoming or latest, defined by the model.
class LaunchesTab extends StatelessWidget {
  final LaunchType type;

  const LaunchesTab(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestSliverPage<LaunchesCubit, List<List<Launch>>>(
        title: context.translate(
          type == LaunchType.upcoming
              ? 'spacex.upcoming.title'
              : 'spacex.latest.title',
        ),
        headerBuilder: (context, state, value) {
          final launch = type == LaunchType.latest
              ? LaunchUtils.getLatestLaunch(value)
              : null;
          return SwiperHeader(
            list: launch?.hasPhotos == true
                ? launch.photos
                : SpaceXPhotos.upcoming,
          );
        },
        popupMenu: Menu.home,
        childrenBuilder: (context, state, value) {
          final launches = value[type.index];
          return [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LaunchCell(launches.elementAt(index)),
                childCount: launches.length,
              ),
            ),
          ];
        },
      ),
      floatingActionButton: RequestBuilder<LaunchesCubit, List<List<Launch>>>(
        onLoaded: (context, state, value) => FloatingActionButton(
          heroTag: null,
          tooltip: context.translate(
            'spacex.other.tooltip.search',
          ),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchPage<Launch>(
              items: LaunchUtils.getAllLaunches(value),
              searchLabel: context.translate(
                'spacex.other.tooltip.search',
              ),
              suggestion: BigTip(
                title: Text(
                  context.translate(
                    type == LaunchType.upcoming
                        ? 'spacex.upcoming.title'
                        : 'spacex.latest.title',
                  ),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  context.translate('spacex.search.suggestion.launch'),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                ),
                child: Icon(Icons.search),
              ),
              failure: BigTip(
                title: Text(
                  context.translate(
                    type == LaunchType.upcoming
                        ? 'spacex.upcoming.title'
                        : 'spacex.latest.title',
                  ),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  context.translate('spacex.search.failure'),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                ),
                child: Icon(Icons.sentiment_dissatisfied),
              ),
              filter: (launch) => [
                launch.rocket.name,
                launch.name,
                launch.flightNumber.toString(),
                launch.year,
                launch.launchpad.name,
                launch.launchpad.fullName,
                ...launch.rocket.payloads.map((e) => e.customer),
                ...launch.rocket.cores.map((e) => e.landpad?.name),
                ...launch.rocket.cores.map((e) => e.landpad?.fullName),
                ...launch.rocket.cores.map(
                  (e) => e.getBlockData(context),
                ),
                ...launch.rocket.cores.map((e) => e.serial),
                ...launch.rocket.payloads.map((e) => e.capsule?.serial),
              ],
              builder: (launch) => LaunchCell(launch),
            ),
          ),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}

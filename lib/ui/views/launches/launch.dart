import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../../cubits/index.dart';
import '../../../models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';
import '../vehicles/index.dart';
import 'index.dart';

/// This view displays all information about a specific launch.
class LaunchPage extends StatelessWidget {
  final String id;

  const LaunchPage(this.id);

  static const route = '/launch';

  @override
  Widget build(BuildContext context) {
    final _launch = context.watch<LaunchesCubit>().getLaunch(id);
    return Scaffold(
      body: SliverFab(
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        floatingWidget: !_launch.tentativeTime
            ? SafeArea(
                top: false,
                bottom: false,
                left: false,
                child: _launch.hasVideo
                    ? FloatingActionButton(
                        heroTag: null,
                        tooltip: context.translate(
                          'spacex.other.tooltip.watch_replay',
                        ),
                        onPressed: () => context.openUrl(_launch.getVideo),
                        child: Icon(Icons.ondemand_video),
                      )
                    : FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Theme.of(context).accentColor,
                        tooltip: context.translate(
                          'spacex.other.tooltip.add_event',
                        ),
                        onPressed: () async {
                          await Add2Calendar.addEvent2Cal(Event(
                            title: _launch.name,
                            description: _launch.details ??
                                context.translate(
                                  'spacex.launch.page.no_description',
                                ),
                            location: _launch.launchpad.name ??
                                context.translate('spacex.other.unknown'),
                            startDate: _launch.localLaunchDate,
                            endDate: _launch.localLaunchDate.add(
                              Duration(minutes: 30),
                            ),
                          ));
                        },
                        child: Icon(Icons.event),
                      ),
              )
            : Separator.none(),
        slivers: <Widget>[
          SliverBar(
            title: _launch.name,
            header: SwiperHeader(
              list: _launch.hasPhotos
                  ? _launch.photos
                  : List.from(SpaceXPhotos.upcoming)
                ..shuffle(),
            ),
            actions: <Widget>[
              IconButton(
                icon: IconShadow(Icons.adaptive.share),
                onPressed: () => Share.share(
                  context.translate(
                    _launch.localLaunchDate.isAfter(DateTime.now())
                        ? 'spacex.other.share.launch.future'
                        : 'spacex.other.share.launch.past',
                    parameters: {
                      'number': _launch.flightNumber.toString(),
                      'name': _launch.name,
                      'launchpad': _launch.launchpad.name ??
                          context.translate('spacex.other.unknown'),
                      'date': _launch.getTentativeDate,
                      'details': Url.shareDetails
                    },
                  ),
                ),
                tooltip: context.translate('spacex.other.menu.share'),
              ),
            ],
            menuItemBuilder: (context) => [
              for (final url in Menu.launch)
                PopupMenuItem(
                  value: url,
                  enabled: _launch.isUrlEnabled(url),
                  child: Text(context.translate(url)),
                )
            ],
            onMenuItemSelected: (name) => context.openUrl(_launch.getUrl(name)),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.cards(children: <Widget>[
                _missionCard(context),
                _firstStageCard(context),
                _secondStageCard(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _missionCard(BuildContext context) {
    final _launch = context.watch<LaunchesCubit>().getLaunch(id);
    return CardCell.header(
      context,
      leading: AbsorbPointer(
        absorbing: !_launch.hasPatch,
        child: ProfileImage.big(
          _launch.patchUrl,
          onTap: () => context.openUrl(_launch.patchUrl),
        ),
      ),
      title: _launch.name,
      subtitle: [
        ItemCell(
          icon: Icons.calendar_today,
          text: _launch.getLaunchDate(context),
        ),
        ItemCell(
          icon: Icons.location_on,
          text: _launch.launchpad.name ??
              context.translate('spacex.other.unknown'),
          onTap: _launch.launchpad.name == null
              ? null
              : () => Navigator.pushNamed(
                    context,
                    LaunchpadPage.route,
                    arguments: {'launchId': id},
                  ),
        ),
      ],
      details: _launch.getDetails(context),
    );
  }

  Widget _firstStageCard(BuildContext context) {
    final _launch = context.watch<LaunchesCubit>().getLaunch(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.launch.page.rocket.title'),
      child: RowLayout(children: <Widget>[
        RowTap(
          context.translate('spacex.launch.page.rocket.model'),
          _launch.rocket.name,
          onTap: () => Navigator.pushNamed(
            context,
            VehiclePage.route,
            arguments: {
              'id': _launch.rocket.id,
            },
          ),
        ),
        if (_launch.avoidedStaticFire)
          RowItem.boolean(
            context.translate('spacex.launch.page.rocket.static_fire_date'),
            false,
          )
        else
          RowItem.text(
            context.translate('spacex.launch.page.rocket.static_fire_date'),
            _launch.getStaticFireDate(context),
          ),
        RowItem.text(
          context.translate('spacex.launch.page.rocket.launch_window'),
          _launch.getLaunchWindow(context),
        ),
        if (!_launch.upcoming)
          RowItem.boolean(
            context.translate('spacex.launch.page.rocket.launch_success'),
            _launch.success,
          ),
        if (_launch.success == false) ...<Widget>[
          Separator.divider(),
          RowItem.text(
            context.translate('spacex.launch.page.rocket.failure.time'),
            _launch.failure.getTime,
          ),
          RowItem.text(
            context.translate('spacex.launch.page.rocket.failure.altitude'),
            _launch.failure.getAltitude(context),
          ),
          ExpandText(_launch.failure.getReason)
        ],
        for (final core in _launch.rocket.cores)
          _getCores(
            context,
            core,
            isUpcoming: _launch.upcoming,
          ),
      ]),
    );
  }

  Widget _secondStageCard(BuildContext context) {
    final _launch = context.watch<LaunchesCubit>().getLaunch(id);
    final _fairings = _launch.rocket.fairings;

    return CardCell.body(
      context,
      title: context.translate('spacex.launch.page.payload.title'),
      child: RowLayout(children: <Widget>[
        if (_launch.rocket.hasFairings) ...<Widget>[
          RowItem.boolean(
            context.translate('spacex.launch.page.payload.fairings.reused'),
            _fairings.reused,
          ),
          if (_fairings.recoveryAttempt == true)
            RowItem.boolean(
              context.translate(
                'spacex.launch.page.payload.fairings.recovery_success',
              ),
              _fairings.recovered,
            )
          else
            RowItem.boolean(
              context.translate(
                'spacex.launch.page.payload.fairings.recovery_attempt',
              ),
              _fairings.recoveryAttempt,
            ),
        ],
        if (_fairings != null) Separator.divider(),
        _getPayload(context, _launch.rocket.getSinglePayload),
        if (_launch.rocket.hasMultiplePayload)
          ExpandList(
            hint: context.translate('spacex.other.all_payload'),
            child: Column(children: <Widget>[
              for (final payload in _launch.rocket.payloads.sublist(1)) ...[
                Separator.divider(),
                Separator.spacer(),
                _getPayload(context, payload),
                if (_launch.rocket.payloads.indexOf(payload) !=
                    _launch.rocket.payloads.length - 1)
                  Separator.spacer(),
              ]
            ]),
          )
      ]),
    );
  }

  Widget _getCores(BuildContext context, Core core, {bool isUpcoming = false}) {
    return RowLayout(children: <Widget>[
      Separator.divider(),
      RowTap(
        context.translate('spacex.launch.page.rocket.core.serial'),
        core.serial,
        onTap: () => Navigator.pushNamed(
          context,
          CorePage.route,
          arguments: {
            'launchId': id,
            'coreId': core.id,
          },
        ),
      ),
      RowItem.text(
        context.translate('spacex.launch.page.rocket.core.model'),
        core.getBlock(context),
      ),
      RowItem.boolean(
        context.translate('spacex.launch.page.rocket.core.reused'),
        core.reused,
      ),
      if (core.landingAttempt == true) ...<Widget>[
        RowTap(
          context.translate('spacex.launch.page.rocket.core.landing_zone'),
          core.landpad?.name,
          onTap: () => Navigator.pushNamed(
            context,
            LandpadPage.route,
            arguments: {
              'launchId': id,
              'coreId': core.id,
            },
          ),
        ),
        if (!isUpcoming)
          RowItem.boolean(
            context.translate('spacex.launch.page.rocket.core.landing_success'),
            core.landingSuccess,
          )
      ] else
        RowItem.boolean(
          context.translate('spacex.launch.page.rocket.core.landing_attempt'),
          core.landingAttempt,
        ),
      if (core.landingAttempt == true)
        ExpandChild(
          child: RowLayout(children: <Widget>[
            RowItem.boolean(
              context.translate('spacex.launch.page.rocket.core.landing_legs'),
              core.hasLegs,
            ),
            RowItem.boolean(
              context.translate('spacex.launch.page.rocket.core.gridfins'),
              core.hasGridfins,
            ),
          ]),
        ),
    ]);
  }

  Widget _getPayload(BuildContext context, Payload payload) {
    return RowLayout(children: <Widget>[
      RowItem.text(
        context.translate('spacex.launch.page.payload.name'),
        payload.getName(context),
      ),
      if (payload.isNasaPayload) ...<Widget>[
        RowTap(
          context.translate('spacex.launch.page.payload.capsule_serial'),
          payload.capsule?.serial,
          onTap: () => Navigator.pushNamed(
            context,
            CapsulePage.route,
            arguments: {
              'launchId': id,
            },
          ),
        ),
        RowItem.boolean(
          context.translate('spacex.launch.page.payload.capsule_reused'),
          payload.reused,
        ),
      ],
      RowItem.text(
        context.translate('spacex.launch.page.payload.manufacturer'),
        payload.getManufacturer(context),
      ),
      RowItem.text(
        context.translate('spacex.launch.page.payload.customer'),
        payload.getCustomer(context),
      ),
      RowItem.text(
        context.translate('spacex.launch.page.payload.nationality'),
        payload.getNationality(context),
      ),
      RowItem.text(
        context.translate('spacex.launch.page.payload.mass'),
        payload.getMass(context),
      ),
      RowItem.text(
        context.translate('spacex.launch.page.payload.orbit'),
        payload.getOrbit(context),
      ),
      ExpandChild(
        child: RowLayout(children: <Widget>[
          RowItem.text(
            context.translate('spacex.launch.page.payload.periapsis'),
            payload.getPeriapsis(context),
          ),
          RowItem.text(
            context.translate('spacex.launch.page.payload.apoapsis'),
            payload.getApoapsis(context),
          ),
          RowItem.text(
            context.translate('spacex.launch.page.payload.inclination'),
            payload.getInclination(context),
          ),
          RowItem.text(
            context.translate('spacex.launch.page.payload.period'),
            payload.getPeriod(context),
          ),
        ]),
      )
    ]);
  }
}

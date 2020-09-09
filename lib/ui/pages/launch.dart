import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:share/share.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../models/index.dart';
import '../../repositories/index.dart';
import '../../util/index.dart';
import '../widgets/index.dart';
import 'index.dart';

/// This view displays all information about a specific launch.
class LaunchPage extends StatelessWidget {
  final String id;

  const LaunchPage(this.id);

  @override
  Widget build(BuildContext context) {
    final _launch = context.watch<LaunchesRepository>().getLaunch(id);
    return Scaffold(
      body: SliverFab(
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        floatingWidget: SafeArea(
          top: false,
          bottom: false,
          left: false,
          child: _launch.hasVideo
              ? FloatingActionButton(
                  heroTag: null,
                  tooltip: FlutterI18n.translate(
                    context,
                    'spacex.other.tooltip.watch_replay',
                  ),
                  onPressed: () => FlutterWebBrowser.openWebPage(
                    url: _launch.getVideo,
                    androidToolbarColor: Theme.of(context).primaryColor,
                  ),
                  child: Icon(Icons.ondemand_video),
                )
              : FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Theme.of(context).accentColor,
                  tooltip: FlutterI18n.translate(
                    context,
                    'spacex.other.tooltip.add_event',
                  ),
                  onPressed: () async {
                    await Add2Calendar.addEvent2Cal(Event(
                      title: _launch.name,
                      description: _launch.details ??
                          FlutterI18n.translate(
                            context,
                            'spacex.launch.page.no_description',
                          ),
                      location: _launch.launchpad.name ??
                          FlutterI18n.translate(
                            context,
                            'spacex.other.unknown',
                          ),
                      startDate: _launch.launchDate,
                      endDate: _launch.launchDate.add(
                        Duration(minutes: 30),
                      ),
                    ));
                  },
                  child: Icon(Icons.event),
                ),
        ),
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
                icon: Icon(Icons.share),
                onPressed: () => Share.share(
                  FlutterI18n.translate(
                    context,
                    _launch.launchDate.isAfter(DateTime.now())
                        ? 'spacex.other.share.launch.future'
                        : 'spacex.other.share.launch.past',
                    translationParams: {
                      'number': _launch.flightNumber.toString(),
                      'name': _launch.name,
                      'launchpad': _launch.launchpad.name ??
                          FlutterI18n.translate(
                            context,
                            'spacex.other.unknown',
                          ),
                      'date': _launch.getTentativeDate,
                      'details': Url.shareDetails
                    },
                  ),
                ),
                tooltip: FlutterI18n.translate(
                  context,
                  'spacex.other.menu.share',
                ),
              ),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  for (final url in Menu.launch)
                    PopupMenuItem(
                      value: url,
                      enabled: _launch.isUrlEnabled(context, url),
                      child: Text(FlutterI18n.translate(context, url)),
                    )
                ],
                onSelected: (name) => FlutterWebBrowser.openWebPage(
                  url: _launch.getUrl(context, name),
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
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
    final _launch = context.watch<LaunchesRepository>().getLaunch(id);
    return CardCell.header(
      context,
      leading: AbsorbPointer(
        absorbing: !_launch.hasPatch,
        child: ProfileImage.big(
          _launch.patchUrl,
          onTap: () => FlutterWebBrowser.openWebPage(
            url: _launch.patchUrl,
            androidToolbarColor: Theme.of(context).primaryColor,
          ),
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
              FlutterI18n.translate(context, 'spacex.other.unknown'),
          // TODO
          // onTap: _launch.launchpad.name == null
          //     ? null
          //     : () => Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => LaunchpadPage(),
          //             fullscreenDialog: true,
          //           ),
          //         ),
        ),
      ],
      details: _launch.getDetails(context),
    );
  }

  Widget _firstStageCard(BuildContext context) {
    final _launch = context.watch<LaunchesRepository>().getLaunch(id);
    return CardCell.body(
      context,
      title: FlutterI18n.translate(
        context,
        'spacex.launch.page.rocket.title',
      ),
      child: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.rocket.model',
          ),
          _launch.rocket.name,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.rocket.static_fire_date',
          ),
          _launch.getStaticFireDate(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.rocket.launch_window',
          ),
          _launch.getLaunchWindow(context),
        ),
        RowBoolean(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.rocket.launch_success',
          ),
          _launch.success,
        ),
        // TODO
        // if (_launch.success == false) ...<Widget>[
        //   Separator.divider(),
        //   RowText(
        //     FlutterI18n.translate(
        //       context,
        //       'spacex.launch.page.rocket.failure.time',
        //     ),
        //     _launch.failureDetails.getTime,
        //   ),
        //   RowText(
        //     FlutterI18n.translate(
        //       context,
        //       'spacex.launch.page.rocket.failure.altitude',
        //     ),
        //     _launch.failureDetails.getAltitude(context),
        //   ),
        //   TextExpand(_launch.failureDetails.getReason)
        // ],
        for (final core in _launch.rocket.cores) _getCores(context, core),
      ]),
    );
  }

  Widget _secondStageCard(BuildContext context) {
    final _launch = context.watch<LaunchesRepository>().getLaunch(id);
    final _fairings = _launch.rocket.fairings;

    return CardCell.body(
      context,
      title: FlutterI18n.translate(
        context,
        'spacex.launch.page.payload.title',
      ),
      child: RowLayout(children: <Widget>[
        if (_launch.rocket.hasFairings) ...<Widget>[
          RowBoolean(
            FlutterI18n.translate(
              context,
              'spacex.launch.page.payload.fairings.reused',
            ),
            _fairings.reused,
          ),
          if (_fairings.recoveryAttempt == true)
            RowBoolean(
              FlutterI18n.translate(
                context,
                'spacex.launch.page.payload.fairings.recovery_success',
              ),
              _fairings.recovered,
            )
          else
            RowBoolean(
              FlutterI18n.translate(
                context,
                'spacex.launch.page.payload.fairings.recovery_attempt',
              ),
              _fairings.recoveryAttempt,
            ),
        ],
        if (_fairings != null) Separator.divider(),
        _getPayload(context, _launch.rocket.getSinglePayload),
        if (_launch.rocket.hasMultiplePayload)
          ExpandList(
            text: FlutterI18n.translate(
              context,
              'spacex.other.all_payload',
            ),
            child: Column(children: <Widget>[
              for (final Payload payload
                  in _launch.rocket.payloads.sublist(1)) ...[
                Separator.divider(),
                _getPayload(context, payload),
              ]
            ]),
          )
      ]),
    );
  }

  Widget _getCores(BuildContext context, Core core) {
    return RowLayout(children: <Widget>[
      Separator.divider(),
      RowTap(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.rocket.core.serial',
        ),
        core.serial,
        //TODO
        // screenBuilder: (_) => CoreDialog(),
        fallback: FlutterI18n.translate(context, 'spacex.other.unknown'),
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.rocket.core.model',
        ),
        core.getBlock(context),
      ),
      RowBoolean(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.rocket.core.reused',
        ),
        core.reused,
      ),
      if (core.landingAttempt == true) ...<Widget>[
        RowTap(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.rocket.core.landing_zone',
          ),
          core.landpad?.name,
          //TODO
          // screenBuilder: (_) => LandpadPage(),
          fallback: FlutterI18n.translate(context, 'spacex.other.unknown'),
        ),
        RowBoolean(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.rocket.core.landing_success',
          ),
          core.landingSuccess,
        )
      ] else
        RowBoolean(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.rocket.core.landing_attempt',
          ),
          core.landingAttempt,
        ),
      ExpandChild(
        child: RowLayout(children: <Widget>[
          RowBoolean(
            FlutterI18n.translate(
              context,
              'spacex.launch.page.rocket.core.landing_legs',
            ),
            core.hasLegs,
          ),
          RowBoolean(
            FlutterI18n.translate(
              context,
              'spacex.launch.page.rocket.core.gridfins',
            ),
            core.hasGridfins,
          ),
        ]),
      ),
    ]);
  }

  Widget _getPayload(BuildContext context, Payload payload) {
    return RowLayout(children: <Widget>[
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.payload.name',
        ),
        payload.getName(context),
      ),
      if (payload.isNasaPayload) ...<Widget>[
        RowTap(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.payload.capsule_serial',
          ),
          payload.capsule?.serial,
          //TODO
          // screenBuilder: (_) => CapsulePage(),
          fallback: FlutterI18n.translate(context, 'spacex.other.unknown'),
        ),
        RowBoolean(
          FlutterI18n.translate(
            context,
            'spacex.launch.page.payload.capsule_reused',
          ),
          payload.reused,
        ),
      ],
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.payload.manufacturer',
        ),
        payload.getManufacturer(context),
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.payload.customer',
        ),
        payload.getCustomer(context),
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.payload.nationality',
        ),
        payload.getNationality(context),
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.payload.mass',
        ),
        payload.getMass(context),
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.launch.page.payload.orbit',
        ),
        payload.getOrbit(context),
      ),
      ExpandChild(
        child: RowLayout(children: <Widget>[
          RowText(
            FlutterI18n.translate(
              context,
              'spacex.launch.page.payload.periapsis',
            ),
            payload.getPeriapsis(context),
          ),
          RowText(
            FlutterI18n.translate(
              context,
              'spacex.launch.page.payload.apoapsis',
            ),
            payload.getApoapsis(context),
          ),
          RowText(
            FlutterI18n.translate(
              context,
              'spacex.launch.page.payload.inclination',
            ),
            payload.getInclination(context),
          ),
          RowText(
            FlutterI18n.translate(
              context,
              'spacex.launch.page.payload.period',
            ),
            payload.getPeriod(context),
          ),
        ]),
      )
    ]);
  }
}

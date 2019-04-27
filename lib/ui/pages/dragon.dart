import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:share/share.dart';

import '../../models/info_capsule.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../../widgets/cache_image.dart';
import '../../widgets/card_page.dart';
import '../../widgets/expand_widget.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/row_item.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';

/// DRAGON PAGE VIEW
/// This view all information about a Dragon capsule model. It displays CapsuleInfo's specs.
class DragonPage extends StatelessWidget {
  final CapsuleInfo _capsule;

  DragonPage(this._capsule);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: Text(_capsule.name),
          header: SwiperHeader(
            list: _capsule.photos,
            builder: (_, index) {
              final CacheImage photo = CacheImage(_capsule.getPhoto(index));
              return index == 0 ? Hero(tag: _capsule.id, child: photo) : photo;
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => Share.share(
                    FlutterI18n.translate(
                      context,
                      'spacex.other.share.capsule.body',
                      {
                        'name': _capsule.name,
                        'launch_payload': _capsule.getLaunchMass,
                        'return_payload': _capsule.getReturnMass,
                        'people': _capsule.isCrewEnabled
                            ? FlutterI18n.translate(
                                context,
                                'spacex.other.share.capsule.people',
                                {'people': _capsule.crew.toString()},
                              )
                            : FlutterI18n.translate(
                                context,
                                'spacex.other.share.capsule.no_people',
                              ),
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
              itemBuilder: (_) => Menu.wikipedia
                  .map((string) => PopupMenuItem(
                        value: string,
                        child: Text(FlutterI18n.translate(context, string)),
                      ))
                  .toList(),
              onSelected: (_) async => await FlutterWebBrowser.openWebPage(
                    url: _capsule.url,
                    androidToolbarColor: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              _capsuleCard(context),
              Separator.cardSpacer(),
              _specsCard(context),
              Separator.cardSpacer(),
              _thrustersCard(context),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _capsuleCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.description.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.launch_maiden',
          ),
          _capsule.getFullFirstFlight,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.crew_capacity',
          ),
          _capsule.getCrew(context),
        ),
        Separator.spacer(),
        RowItem.iconRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.active',
          ),
          _capsule.active,
        ),
        Separator.divider(),
        TextExpand(text: _capsule.description, maxLength: 7)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.specifications.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_launch',
          ),
          _capsule.getLaunchMass,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_return',
          ),
          _capsule.getReturnMass,
        ),
        Separator.spacer(),
        RowItem.iconRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.reusable',
          ),
          _capsule.reusable,
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.height',
          ),
          _capsule.getHeight,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.diameter',
          ),
          _capsule.getDiameter,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.mass',
          ),
          _capsule.getMass(context),
        ),
      ]),
    );
  }

  Widget _thrustersCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.thruster.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
            context,
            FlutterI18n.translate(
              context,
              'spacex.vehicle.capsule.thruster.systems',
            ),
            _capsule.getThrusters),
        Column(
          children: _capsule.thrusters
              .map((thruster) => _getThruster(context, thruster))
              .toList(),
        )
      ]),
    );
  }

  Widget _getThruster(BuildContext context, Thruster thruster) {
    return Column(children: <Widget>[
      Separator.divider(),
      RowItem.textRow(
        context,
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.name',
        ),
        thruster.name,
      ),
      Separator.spacer(),
      RowItem.textRow(
        context,
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.amount',
        ),
        thruster.getAmount,
      ),
      Separator.spacer(),
      RowItem.textRow(
        context,
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.fuel',
        ),
        thruster.getFuel,
      ),
      Separator.spacer(),
      RowItem.textRow(
        context,
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.oxidizer',
        ),
        thruster.getOxidizer,
      ),
      Separator.spacer(),
      RowItem.textRow(
        context,
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.thrust',
        ),
        thruster.getThrust,
      ),
    ]);
  }
}

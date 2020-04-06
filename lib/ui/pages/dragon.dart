import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:share/share.dart';

import '../../models/index.dart';
import '../../repositories/vehicles.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../widgets/index.dart';

/// This view all information about a Dragon capsule model. It displays CapsuleInfo's specs.
class DragonPage extends StatelessWidget {
  final String id;

  const DragonPage(this.id);

  @override
  Widget build(BuildContext context) {
    final DragonInfo _dragon =
        context.read<VehiclesRepository>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _dragon.name,
          header: SwiperHeader(
            list: _dragon.photos,
            builder: (context, index) {
              final CacheImage photo = CacheImage(_dragon.getPhoto(index));
              return index == 0
                  ? Hero(
                      tag: '${_dragon.id}${_dragon.getPhoto(index)}',
                      child: photo,
                    )
                  : photo;
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(
                FlutterI18n.translate(
                  context,
                  'spacex.other.share.capsule.body',
                  translationParams: {
                    'name': _dragon.name,
                    'launch_payload': _dragon.getLaunchMass,
                    'return_payload': _dragon.getReturnMass,
                    'people': _dragon.isCrewEnabled
                        ? FlutterI18n.translate(
                            context,
                            'spacex.other.share.capsule.people',
                            translationParams: {
                              'people': _dragon.crew.toString()
                            },
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
              itemBuilder: (context) => [
                for (final item in Menu.wikipedia)
                  PopupMenuItem(
                    value: item,
                    child: Text(FlutterI18n.translate(context, item)),
                  )
              ],
              onSelected: (text) => FlutterWebBrowser.openWebPage(
                url: _dragon.url,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverToBoxAdapter(
            child: RowLayout.cards(children: <Widget>[
              _capsuleCard(context),
              _specsCard(context),
              _thrustersCard(context),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _capsuleCard(BuildContext context) {
    final DragonInfo _dragon =
        context.read<VehiclesRepository>().getVehicle(id);
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.description.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.launch_maiden',
          ),
          _dragon.getFullFirstFlight,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.crew_capacity',
          ),
          _dragon.getCrew(context),
        ),
        RowIcon(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.active',
          ),
          _dragon.active,
        ),
        Separator.divider(),
        TextExpand(_dragon.description)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    final DragonInfo _dragon =
        context.read<VehiclesRepository>().getVehicle(id);
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.specifications.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_launch',
          ),
          _dragon.getLaunchMass,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_return',
          ),
          _dragon.getReturnMass,
        ),
        RowIcon(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.reusable',
          ),
          _dragon.reusable,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.height',
          ),
          _dragon.getHeight,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.diameter',
          ),
          _dragon.getDiameter,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.mass',
          ),
          _dragon.getMass(context),
        ),
      ]),
    );
  }

  Widget _thrustersCard(BuildContext context) {
    final DragonInfo _dragon =
        context.read<VehiclesRepository>().getVehicle(id);
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.thruster.title',
      ),
      body: RowLayout(children: <Widget>[
        for (final thruster in _dragon.thrusters)
          _getThruster(
            context: context,
            thruster: thruster,
            isFirst: _dragon.thrusters.first == thruster,
          ),
      ]),
    );
  }

  Widget _getThruster({BuildContext context, Thruster thruster, bool isFirst}) {
    return RowLayout(children: <Widget>[
      if (!isFirst) Separator.divider(),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.model',
        ),
        thruster.model,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.amount',
        ),
        thruster.getAmount,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.fuel',
        ),
        thruster.getFuel,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.oxidizer',
        ),
        thruster.getOxidizer,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.thrust',
        ),
        thruster.getThrust,
      ),
      RowText(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.isp',
        ),
        thruster.getIsp,
      ),
    ]);
  }
}

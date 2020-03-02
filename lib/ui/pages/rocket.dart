import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:share/share.dart';

import '../../models/info_rocket.dart';
import '../../repositories/vehicles.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../widgets/index.dart';

/// This view all information about a Falcon rocket model. It displays RocketInfo's specs.
class RocketPage extends StatelessWidget {
  final String id;

  const RocketPage(this.id);

  @override
  Widget build(BuildContext context) {
    final RocketInfo _rocket =
        context.read<VehiclesRepository>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _rocket.name,
          header: SwiperHeader(
            list: _rocket.photos,
            builder: (context, index) {
              final CacheImage photo = CacheImage(_rocket.getPhoto(index));
              return index == 0
                  ? Hero(
                      tag: '${_rocket.id}${_rocket.getPhoto(index)}',
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
                  'spacex.other.share.rocket',
                  translationParams: {
                    'name': _rocket.name,
                    'height': _rocket.getHeight,
                    'engines': _rocket.firstStage.engines.toString(),
                    'type': _rocket.engine.getName,
                    'thrust': _rocket.firstStage.getThrust,
                    'payload': _rocket.payloadWeights[0].getMass,
                    'orbit': _rocket.payloadWeights[0].name,
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
                url: _rocket.url,
                androidToolbarColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverToBoxAdapter(
            child: RowLayout.cards(children: <Widget>[
              _rocketCard(context),
              _specsCard(context),
              _payloadsCard(context),
              _stages(context),
              _enginesCard(context),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _rocketCard(BuildContext context) {
    final RocketInfo _rocket =
        context.read<VehiclesRepository>().getVehicle(id);
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.description.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.launch_maiden',
          ),
          _rocket.getFullFirstFlight,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.launch_cost',
          ),
          _rocket.getLaunchCost,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.success_rate',
          ),
          _rocket.getSuccessRate(context),
        ),
        RowIcon(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.active',
          ),
          _rocket.active,
        ),
        Separator.divider(),
        TextExpand(_rocket.description)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    final RocketInfo _rocket =
        context.read<VehiclesRepository>().getVehicle(id);
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.specifications.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.rocket_stages',
          ),
          _rocket.getStages(context),
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.height',
          ),
          _rocket.getHeight,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.diameter',
          ),
          _rocket.getDiameter,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.mass',
          ),
          _rocket.getMass(context),
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.fairing_height',
          ),
          _rocket.fairingHeight(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.fairing_diameter',
          ),
          _rocket.fairingDiameter(context),
        ),
      ]),
    );
  }

  Widget _payloadsCard(BuildContext context) {
    final RocketInfo _rocket =
        context.read<VehiclesRepository>().getVehicle(id);
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.capability.title',
      ),
      body: RowLayout(
        children: <Widget>[
          for (final payloadWeight in _rocket.payloadWeights)
            RowText(
              payloadWeight.name,
              payloadWeight.getMass,
            ),
        ],
      ),
    );
  }

  Widget _stages(BuildContext context) {
    final RocketInfo _rocket =
        context.read<VehiclesRepository>().getVehicle(id);
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.thrust_first_stage',
          ),
          _rocket.firstStage.getThrust,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.fuel_amount',
          ),
          _rocket.firstStage.getFuelAmount(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.engines',
          ),
          _rocket.firstStage.getEngines(context),
        ),
        RowIcon(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.reusable',
          ),
          _rocket.firstStage.reusable,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.thrust_second_stage',
          ),
          _rocket.secondStage.getThrust,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.fuel_amount',
          ),
          _rocket.secondStage.getFuelAmount(context),
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.engines',
          ),
          _rocket.secondStage.getEngines(context),
        ),
        RowIcon(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.reusable',
          ),
          _rocket.secondStage.reusable,
        ),
      ]),
    );
  }

  Widget _enginesCard(BuildContext context) {
    final Engine _engine =
        (context.read<VehiclesRepository>().getVehicle(id) as RocketInfo)
            .engine;

    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.engines.title',
      ),
      body: RowLayout(children: <Widget>[
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.model',
          ),
          _engine.getName,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_weight',
          ),
          _engine.getThrustToWeight(context),
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.fuel',
          ),
          _engine.getFuel,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.oxidizer',
          ),
          _engine.getOxidizer,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_sea',
          ),
          _engine.getThrustSea,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_vacuum',
          ),
          _engine.getThrustVacuum,
        ),
        Separator.divider(),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.isp_sea',
          ),
          _engine.getIspSea,
        ),
        RowText(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.isp_vacuum',
          ),
          _engine.getIspVacuum,
        ),
      ]),
    );
  }
}

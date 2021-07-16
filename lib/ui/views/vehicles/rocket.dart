import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';
import 'package:share_plus/share_plus.dart';

import '../../../cubits/index.dart';
import '../../../models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

/// This view all information about a Falcon rocket model. It displays RocketInfo's specs.
class RocketPage extends StatelessWidget {
  final String id;

  const RocketPage(this.id);

  @override
  Widget build(BuildContext context) {
    final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _rocket.name,
          header: SwiperHeader(
            list: _rocket.photos,
            builder: (_, index) => CacheImage(_rocket.getPhoto(index)),
          ),
          actions: <Widget>[
            IconButton(
              icon: IconShadow(Icons.adaptive.share),
              onPressed: () => Share.share(
                context.translate(
                  'spacex.other.share.rocket',
                  parameters: {
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
              tooltip: context.translate('spacex.other.menu.share'),
            ),
          ],
          menuItemBuilder: (context) => [
            for (final item in Menu.wikipedia)
              PopupMenuItem(
                value: item,
                child: Text(context.translate(item)),
              )
          ],
          onMenuItemSelected: (text) => context.openUrl(_rocket.url),
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
    final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.description.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.rocket.description.launch_maiden'),
          _rocket.getFullFirstFlight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.description.launch_cost'),
          _rocket.getLaunchCost,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.description.success_rate'),
          _rocket.getSuccessRate(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.rocket.description.active'),
          _rocket.active,
        ),
        Separator.divider(),
        ExpandText(_rocket.description)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.specifications.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context
              .translate('spacex.vehicle.rocket.specifications.rocket_stages'),
          _rocket.getStages(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.specifications.height'),
          _rocket.getHeight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.specifications.diameter'),
          _rocket.getDiameter,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.specifications.mass'),
          _rocket.getMass(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fairing_height'),
          _rocket.fairingHeight(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fairing_diameter'),
          _rocket.fairingDiameter(context),
        ),
      ]),
    );
  }

  Widget _payloadsCard(BuildContext context) {
    final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.capability.title'),
      child: RowLayout(
        children: <Widget>[
          for (final payloadWeight in _rocket.payloadWeights)
            RowItem.text(
              payloadWeight.name,
              payloadWeight.getMass,
            ),
        ],
      ),
    );
  }

  Widget _stages(BuildContext context) {
    final RocketVehicle _rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.stage.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.thrust_first_stage'),
          _rocket.firstStage.getThrust,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fuel_amount'),
          _rocket.firstStage.getFuelAmount(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.engines'),
          _rocket.firstStage.getEngines(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.rocket.stage.reusable'),
          _rocket.firstStage.reusable,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.thrust_second_stage'),
          _rocket.secondStage.getThrust,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fuel_amount'),
          _rocket.secondStage.getFuelAmount(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.engines'),
          _rocket.secondStage.getEngines(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.rocket.stage.reusable'),
          _rocket.secondStage.reusable,
        ),
      ]),
    );
  }

  Widget _enginesCard(BuildContext context) {
    final _engine =
        (context.watch<VehiclesCubit>().getVehicle(id) as RocketVehicle).engine;

    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.engines.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.model'),
          _engine.getName,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.thrust_weight'),
          _engine.getThrustToWeight(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.fuel'),
          _engine.getFuel,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.oxidizer'),
          _engine.getOxidizer,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.thrust_sea'),
          _engine.getThrustSea,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.thrust_vacuum'),
          _engine.getThrustVacuum,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.isp_sea'),
          _engine.getIspSea,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.isp_vacuum'),
          _engine.getIspVacuum,
        ),
      ]),
    );
  }
}

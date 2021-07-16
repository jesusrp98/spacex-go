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

/// This view all information about a Dragon capsule model. It displays CapsuleInfo's specs.
class DragonPage extends StatelessWidget {
  final String id;

  const DragonPage(this.id);

  @override
  Widget build(BuildContext context) {
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _dragon.name,
          header: SwiperHeader(
            list: _dragon.photos,
            builder: (_, index) => CacheImage(_dragon.getPhoto(index)),
          ),
          actions: <Widget>[
            IconButton(
              icon: IconShadow(Icons.adaptive.share),
              onPressed: () => Share.share(
                context.translate(
                  'spacex.other.share.capsule.body',
                  parameters: {
                    'name': _dragon.name,
                    'launch_payload': _dragon.getLaunchMass,
                    'return_payload': _dragon.getReturnMass,
                    'people': _dragon.isCrewEnabled
                        ? context.translate(
                            'spacex.other.share.capsule.people',
                            parameters: {'people': _dragon.crew.toString()},
                          )
                        : context
                            .translate('spacex.other.share.capsule.no_people'),
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
          onMenuItemSelected: (text) => context.openUrl(_dragon.url),
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
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.capsule.description.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.capsule.description.launch_maiden'),
          _dragon.getFullFirstFlight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.description.crew_capacity'),
          _dragon.getCrew(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.capsule.description.active'),
          _dragon.active,
        ),
        Separator.divider(),
        ExpandText(_dragon.description)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.capsule.specifications.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate(
            'spacex.vehicle.capsule.specifications.payload_launch',
          ),
          _dragon.getLaunchMass,
        ),
        RowItem.text(
          context.translate(
            'spacex.vehicle.capsule.specifications.payload_return',
          ),
          _dragon.getReturnMass,
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.capsule.description.reusable'),
          _dragon.reusable,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.specifications.height'),
          _dragon.getHeight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.specifications.diameter'),
          _dragon.getDiameter,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.specifications.mass'),
          _dragon.getMass(context),
        ),
      ]),
    );
  }

  Widget _thrustersCard(BuildContext context) {
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.capsule.thruster.title'),
      child: RowLayout(children: <Widget>[
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
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.model'),
        thruster.model,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.amount'),
        thruster.getAmount,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.fuel'),
        thruster.getFuel,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.oxidizer'),
        thruster.getOxidizer,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.thrust'),
        thruster.getThrust,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.isp'),
        thruster.getIsp,
      ),
    ]);
  }
}

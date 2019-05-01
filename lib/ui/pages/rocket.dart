import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:share/share.dart';

import '../../models/info_rocket.dart';
import '../../util/menu.dart';
import '../../util/url.dart';
import '../../widgets/cache_image.dart';
import '../../widgets/card_page.dart';
import '../../widgets/expand_widget.dart';
import '../../widgets/header_swiper.dart';
import '../../widgets/row_item.dart';
import '../../widgets/separator.dart';
import '../../widgets/sliver_bar.dart';

/// ROCKET PAGE VIEW
/// This view all information about a Falcon rocket model. It displays RocketInfo's specs.
class RocketPage extends StatelessWidget {
  final RocketInfo _rocket;

  RocketPage(this._rocket);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _rocket.name,
          header: SwiperHeader(
            list: _rocket.photos,
            builder: (context, index) {
              final CacheImage photo = CacheImage(_rocket.getPhoto(index));
              return index == 0 ? Hero(tag: _rocket.id, child: photo) : photo;
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(
                    FlutterI18n.translate(
                      context,
                      'spacex.other.share.rocket',
                      {
                        'name': _rocket.name,
                        'height': _rocket.getHeight,
                        'engines': _rocket.firstStage.engines.toString(),
                        'type': _rocket.getEngine,
                        'thrust': _rocket.firstStage.getThrustSea,
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
              itemBuilder: (context) => Menu.wikipedia
                  .map((string) => PopupMenuItem(
                        value: string,
                        child: Text(FlutterI18n.translate(context, string)),
                      ))
                  .toList(),
              onSelected: (text) async => await FlutterWebBrowser.openWebPage(
                    url: _rocket.url,
                    androidToolbarColor: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              _rocketCard(context),
              Separator.cardSpacer(),
              _specsCard(context),
              Separator.cardSpacer(),
              _payloadsCard(context),
              Separator.cardSpacer(),
              _firstStage(context),
              Separator.cardSpacer(),
              _secondStage(context),
              Separator.cardSpacer(),
              _enginesCard(context),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _rocketCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.description.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.launch_maiden',
          ),
          _rocket.getFullFirstFlight,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.launch_cost',
          ),
          _rocket.getLaunchCost,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.success_rate',
          ),
          _rocket.getSuccessRate(context),
        ),
        Separator.spacer(),
        RowItem.iconRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.description.active',
          ),
          _rocket.active,
        ),
        Separator.divider(),
        TextExpand(text: _rocket.description, maxLength: 7)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.specifications.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.rocket_stages',
          ),
          _rocket.getStages(context),
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.height',
          ),
          _rocket.getHeight,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.diameter',
          ),
          _rocket.getDiameter,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.specifications.mass',
          ),
          _rocket.getMass(context),
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.fairing_height',
          ),
          _rocket.fairingHeight(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
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
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.capability.title',
      ),
      body: Column(
        children: _rocket.payloadWeights
            .map(
              (mission) => _getPayloadWeight(
                    context,
                    _rocket.payloadWeights,
                    mission,
                  ),
            )
            .toList(),
      ),
    );
  }

  Column _getPayloadWeight(
    BuildContext context,
    List payloadWeights,
    PayloadWeight payloadWeight,
  ) {
    return Column(children: <Widget>[
      RowItem.textRow(
        context,
        payloadWeight.name,
        payloadWeight.getMass,
      ),
      payloadWeight != payloadWeights.last
          ? Separator.spacer()
          : Separator.none(),
    ]);
  }

  Widget _firstStage(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.stage_first',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.fuel_amount',
          ),
          _rocket.firstStage.getFuelAmount(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.engines',
          ),
          _rocket.firstStage.getEngines(context),
        ),
        Separator.spacer(),
        RowItem.iconRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.reusable',
          ),
          _rocket.firstStage.reusable,
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_sea',
          ),
          _rocket.firstStage.getThrustSea,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_vacuum',
          ),
          _rocket.firstStage.getThrustVacuum,
        ),
      ]),
    );
  }

  Widget _secondStage(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.stage.stage_second',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.fuel_amount',
          ),
          _rocket.secondStage.getFuelAmount(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.engines',
          ),
          _rocket.secondStage.getEngines(context),
        ),
        Separator.spacer(),
        RowItem.iconRow(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.stage.reusable',
          ),
          _rocket.secondStage.reusable,
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_vacuum',
          ),
          _rocket.secondStage.getThrustVacuum,
        ),
      ]),
    );
  }

  Widget _enginesCard(BuildContext context) {
    return CardPage.body(
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.rocket.engines.title',
      ),
      body: Column(children: <Widget>[
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.model',
          ),
          _rocket.getEngine,
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.fuel',
          ),
          _rocket.getFuel,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.oxidizer',
          ),
          _rocket.getOxidizer,
        ),
        Separator.divider(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_weight',
          ),
          _rocket.getEngineThrustToWeight(context),
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_sea',
          ),
          _rocket.getEngineThrustSea,
        ),
        Separator.spacer(),
        RowItem.textRow(
          context,
          FlutterI18n.translate(
            context,
            'spacex.vehicle.rocket.engines.thrust_vacuum',
          ),
          _rocket.getEngineThrustVacuum,
        ),
      ]),
    );
  }
}

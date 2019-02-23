import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/info_vehicle.dart';
import '../../widgets/cache_image.dart';
import '../../widgets/hero_image.dart';
import '../../widgets/list_cell.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/separator.dart';
import '../pages/dragon.dart';
import '../pages/roadster.dart';
import '../pages/rocket.dart';
import '../pages/ship.dart';
import '../search/vehicles.dart';

/// VEHICLES TAB VIEW
/// This tab holds information about all kind of SpaceX's vehicles,
/// such as rockets, capsules, Tesla Roadster & ships.
class VehiclesTab extends StatelessWidget {
  Future<Null> _onRefresh(VehiclesModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) => Scaffold(
            body: RefreshIndicator(
              onRefresh: () => _onRefresh(model),
              child: CustomScrollView(
                  key: PageStorageKey('spacex_vehicles'),
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * 0.3,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(FlutterI18n.translate(
                          context,
                          'spacex.vehicle.title',
                        )),
                        background: model.isLoading
                            ? LoadingIndicator()
                            : Swiper(
                                itemCount: model.getPhotosCount,
                                itemBuilder: (_, index) => CacheImage(
                                      model.getPhoto(index),
                                    ),
                                autoplay: true,
                                autoplayDelay: 6000,
                                duration: 750,
                                onTap: (index) async =>
                                    await FlutterWebBrowser.openWebPage(
                                      url: model.getPhoto(index),
                                      androidToolbarColor:
                                          Theme.of(context).primaryColor,
                                    ),
                              ),
                      ),
                    ),
                    model.isLoading
                        ? SliverFillRemaining(child: LoadingIndicator())
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              _buildVehicle,
                              childCount: model.getItemCount,
                            ),
                          ),
                  ]),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.search),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.tooltip.search',
              ),
              onPressed: () => Navigator.of(context).push(
                    searchVehicles(context, model.items),
                  ),
            ),
          ),
    );
  }

  Widget _buildVehicle(BuildContext context, int index) {
    return ScopedModelDescendant<VehiclesModel>(
      builder: (context, child, model) {
        final Vehicle vehicle = model.getItem(index);
        return Column(children: <Widget>[
          ListCell(
            leading: HeroImage.list(
              url: vehicle.getProfilePhoto,
              tag: vehicle.id,
            ),
            title: vehicle.name,
            subtitle: vehicle.subtitle(context),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => vehicle.type == 'rocket'
                        ? RocketPage(vehicle)
                        : vehicle.type == 'capsule'
                            ? DragonPage(vehicle)
                            : vehicle.type == 'ship'
                                ? ShipPage(vehicle)
                                : RoadsterPage(vehicle),
                  ),
                ),
          ),
          Separator.divider(height: 0, indent: 88)
        ]);
      },
    );
  }
}

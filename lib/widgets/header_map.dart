import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../util/colors.dart';
import '../util/url.dart';

/// MAP HEADER WIDGET
/// Used as a sliver header, in the [background] parameter.
/// It allows to navigate throug a map area, including multiple markers.
class MapHeader extends StatelessWidget {
  final LatLng point;

  MapHeader(this.point);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(center: point, zoom: 6, minZoom: 5, maxZoom: 10),
      layers: <LayerOptions>[
        TileLayerOptions(
          urlTemplate: Url.mapView,
          subdomains: ['a', 'b', 'c', 'd'],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        MarkerLayerOptions(markers: <Marker>[
          Marker(
            width: 45,
            height: 45,
            point: point,
            builder: (_) => const Icon(
                  Icons.location_on,
                  color: locationPin,
                  size: 45,
                ),
          )
        ])
      ],
    );
  }
}

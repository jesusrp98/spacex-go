import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:latlong/latlong.dart';
import 'package:row_collection/row_collection.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/query_model.dart';
import '../util/menu.dart';
import 'header_map.dart';
import 'header_swiper.dart';
import 'sliver_bar.dart';

/// SCROLL PAGE WIDGET
/// This widget is used for all tabs inside the app.
/// Its main features are connection error handeling,
/// pull to refresh, as well as working as a sliver list.
class ScrollPage<T extends QueryModel> extends StatefulWidget {
  final String title;
  final Widget header;
  final ScrollController controller;
  final List<Widget> children, actions;

  const ScrollPage({
    @required this.title,
    @required this.header,
    @required this.children,
    this.controller,
    this.actions,
  });

  @override
  _ScrollPageState<T> createState() => _ScrollPageState<T>();

  factory ScrollPage.photos({
    ScrollController controller,
    @required String title,
    @required List photos,
    @required List<Widget> children,
    List<Widget> actions,
  }) {
    return ScrollPage(
      title: title,
      header: SwiperHeader(list: photos),
      children: children,
      controller: controller,
      actions: actions,
    );
  }

  factory ScrollPage.home({
    @required BuildContext context,
    @required ScrollController controller,
    @required String title,
    @required double opacity,
    @required Widget counter,
    @required List photos,
    @required List<Widget> children,
  }) {
    return ScrollPage(
      title: title,
      header: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: opacity,
            child: Container(
              color: Color(0xFF000000),
              child: SwiperHeader(list: photos),
            ),
          ),
          counter,
        ],
      ),
      children: children,
      controller: controller,
      actions: <Widget>[
        PopupMenuButton<String>(
          itemBuilder: (context) => Menu.home.keys
              .map((string) => PopupMenuItem(
                    value: string,
                    child: Text(FlutterI18n.translate(context, string)),
                  ))
              .toList(),
          onSelected: (text) => Navigator.pushNamed(context, Menu.home[text]),
        ),
      ],
    );
  }

  factory ScrollPage.tab({
    ScrollController controller,
    @required BuildContext context,
    @required String title,
    @required List photos,
    @required List<Widget> children,
  }) {
    return ScrollPage.photos(
      title: title,
      photos: photos,
      children: children,
      controller: controller,
      actions: <Widget>[
        PopupMenuButton<String>(
          itemBuilder: (context) => Menu.home.keys
              .map((string) => PopupMenuItem(
                    value: string,
                    child: Text(FlutterI18n.translate(context, string)),
                  ))
              .toList(),
          onSelected: (text) => Navigator.pushNamed(context, Menu.home[text]),
        ),
      ],
    );
  }

  factory ScrollPage.map({
    ScrollController controller,
    @required String title,
    @required LatLng coordinates,
    @required List<Widget> children,
    List<Widget> actions,
  }) {
    return ScrollPage(
      title: title,
      header: MapHeader(coordinates),
      children: children,
      controller: controller,
      actions: actions,
    );
  }
}

class _ScrollPageState<T extends QueryModel> extends State<ScrollPage> {
  Widget loadingIndicator() => Center(child: CircularProgressIndicator());

  Future<Null> _onRefresh(BuildContext context, T model) {
    Completer<Null> completer = Completer<Null>();
    model.refreshData().then((_) {
      if (model.loadingFailed)
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(FlutterI18n.translate(
              context,
              'spacex.other.loading_error.message',
            )),
            action: SnackBarAction(
              label: FlutterI18n.translate(
                context,
                'spacex.other.loading_error.reload',
              ),
              onPressed: () => _onRefresh(context, model),
            ),
          ),
        );
      completer.complete();
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<T>(
      builder: (context, child, model) => RefreshIndicator(
            onRefresh: () => _onRefresh(context, model),
            child: CustomScrollView(
              key: PageStorageKey(widget.title),
              controller: widget.controller,
              slivers: <Widget>[
                SliverBar(
                  title: widget.title,
                  header: model.isLoading
                      ? loadingIndicator()
                      : model.loadingFailed && model.photos.isEmpty
                          ? Separator.none()
                          : widget.header,
                  actions: widget.actions,
                ),
                if (model.isLoading)
                  SliverFillRemaining(child: loadingIndicator())
                else
                  if (model.loadingFailed && model.items.isEmpty)
                    SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.cloud_off,
                            size: 100,
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                          Column(children: <Widget>[
                            RowLayout(children: <Widget>[
                              Text(
                                FlutterI18n.translate(
                                  context,
                                  'spacex.other.loading_error.message',
                                ),
                                style: TextStyle(fontSize: 17),
                              ),
                              FlatButton(
                                child: Text(
                                  FlutterI18n.translate(
                                    context,
                                    'spacex.other.loading_error.reload',
                                  ),
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color,
                                  ),
                                ),
                                onPressed: () => _onRefresh(context, model),
                              )
                            ])
                          ])
                        ],
                      ),
                    )
                  else
                    ...widget.children,
              ],
            ),
          ),
    );
  }
}

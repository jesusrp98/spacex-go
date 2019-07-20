import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../models/query_model.dart';
import '../util/menu.dart';
import 'header_map.dart';
import 'header_swiper.dart';
import 'sliver_bar.dart';

Widget _loadingIndicator() => Center(child: CircularProgressIndicator());

Future<Null> _onRefresh(BuildContext context, QueryModel model) {
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

/// WIP
class BlanckPage extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;

  const BlanckPage({
    @required this.title,
    @required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontFamily: 'ProductSans'),
        ),
        centerTitle: true,
        actions: actions,
      ),
      body: body,
    );
  }
}

/// WIP
class ReloadablePage<T extends QueryModel> extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;

  const ReloadablePage({
    @required this.title,
    @required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return BlanckPage(
      title: title,
      body: Consumer<T>(
        builder: (context, model, child) => RefreshIndicator(
          onRefresh: () => _onRefresh(context, model),
          child: model.isLoading
              ? _loadingIndicator()
              : model.loadingFailed && model.items.isEmpty
                  ? ConnectionError(model)
                  : body,
        ),
      ),
    );
  }
}

/// This widget is used for all tabs inside the app.
/// Its main features are connection error handeling,
/// pull to refresh, as well as working as a sliver list.
class SliverPage<T extends QueryModel> extends StatelessWidget {
  final String title;
  final Widget header;
  final ScrollController controller;
  final List<Widget> children, actions;

  const SliverPage({
    @required this.title,
    @required this.header,
    @required this.children,
    this.controller,
    this.actions,
  });

  factory SliverPage.photos({
    @required String title,
    @required List photos,
    @required List<Widget> children,
    List<Widget> actions,
  }) {
    return SliverPage(
      title: title,
      header: SwiperHeader(list: photos),
      children: children,
      actions: actions,
    );
  }

  factory SliverPage.home({
    @required BuildContext context,
    @required ScrollController controller,
    @required String title,
    @required double opacity,
    @required Widget counter,
    @required List photos,
    @required List<Widget> children,
  }) {
    return SliverPage(
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

  factory SliverPage.tab({
    @required BuildContext context,
    @required String title,
    @required List photos,
    @required List<Widget> children,
  }) {
    return SliverPage.photos(
      title: title,
      photos: photos,
      children: children,
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

  factory SliverPage.map({
    @required String title,
    @required LatLng coordinates,
    @required List<Widget> children,
    List<Widget> actions,
  }) {
    return SliverPage(
      title: title,
      header: MapHeader(coordinates),
      children: children,
      actions: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, model, child) => RefreshIndicator(
        onRefresh: () => _onRefresh(context, model),
        child: CustomScrollView(
          key: PageStorageKey(title),
          controller: controller,
          slivers: <Widget>[
            SliverBar(
              title: title,
              header: model.isLoading
                  ? _loadingIndicator()
                  : model.loadingFailed && model.photos.isEmpty
                      ? Separator.none()
                      : header,
              actions: actions,
            ),
            if (model.isLoading)
              SliverFillRemaining(child: _loadingIndicator())
            else if (model.loadingFailed && model.items.isEmpty)
              SliverFillRemaining(child: ConnectionError(model))
            else
              ...children,
          ],
        ),
      ),
    );
  }
}

/// WIP
class ConnectionError extends StatelessWidget {
  final QueryModel model;

  const ConnectionError(this.model);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
                child: Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.other.loading_error.reload',
                  ),
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'ProductSans',
                    color: Theme.of(context).textTheme.caption.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _onRefresh(context, model),
              )
            ])
          ])
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';

import '../../data/classes/abstract/query_model.dart';
import 'index.dart';

/// Centered [CircularProgressIndicator] widget.
Widget _loadingIndicator() => Center(child: const CircularProgressIndicator());

/// Function which handles reloading [QueryModel] models.
Future<void> _onRefresh(BuildContext context, QueryModel model) {
  final Completer<void> completer = Completer<void>();
  model.refreshData().then((_) {
    if (model.loadingFailed) {
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
    }
    completer.complete();
  });

  return completer.future;
}

/// Basic screen, which includes an [AppBar] widget.
/// Used when the desired page doesn't have slivers or reloading.
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

/// Basic page which has reloading properties. Used for [QueryModel] models.
/// It uses the [BlanckPage] widget inside it.
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
  final List<Widget> body, actions;
  final Map<String, String> popupMenu;

  const SliverPage({
    @required this.title,
    @required this.header,
    @required this.body,
    this.controller,
    this.actions,
    this.popupMenu,
  });

  factory SliverPage.slide({
    @required String title,
    @required List slides,
    @required List<Widget> body,
    List<Widget> actions,
    Map<String, String> popupMenu,
  }) {
    return SliverPage(
      title: title,
      header: SwiperHeader(list: slides),
      body: body,
      actions: actions,
      popupMenu: popupMenu,
    );
  }

  factory SliverPage.display({
    @required ScrollController controller,
    @required String title,
    @required double opacity,
    @required Widget counter,
    @required List slides,
    @required List<Widget> body,
    List<Widget> actions,
    Map<String, String> popupMenu,
  }) {
    return SliverPage(
      controller: controller,
      title: title,
      header: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: opacity,
            child: SwiperHeader(list: slides),
          ),
          counter,
        ],
      ),
      body: body,
      actions: actions,
      popupMenu: popupMenu,
    );
  }

  factory SliverPage.map({
    @required String title,
    @required LatLng coordinates,
    @required List<Widget> body,
    List<Widget> actions,
    Map<String, String> popupMenu,
  }) {
    return SliverPage(
      title: title,
      header: MapHeader(coordinates),
      body: body,
      actions: actions,
      popupMenu: popupMenu,
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
              actions: <Widget>[
                if (popupMenu != null)
                  PopupMenuButton<String>(
                    itemBuilder: (context) => popupMenu.keys
                        .map((string) => PopupMenuItem(
                              value: string,
                              child:
                                  Text(FlutterI18n.translate(context, string)),
                            ))
                        .toList(),
                    onSelected: (text) =>
                        Navigator.pushNamed(context, popupMenu[text]),
                  ),
                if (actions != null) ...actions,
              ],
            ),
            if (model.isLoading)
              SliverFillRemaining(child: _loadingIndicator())
            else if (model.loadingFailed && model.items.isEmpty)
              SliverFillRemaining(child: ConnectionError(model))
            else
              ...body,
          ],
        ),
      ),
    );
  }
}

/// Widget used to display a connection error message.
/// It allows user to reload the page with a simple button.
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
                onPressed: () => _onRefresh(context, model),
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
              )
            ])
          ])
        ],
      ),
    );
  }
}

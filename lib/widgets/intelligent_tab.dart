import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/query_model.dart';
import '../util/menu.dart';
import 'header_swiper.dart';
import 'loading_indicator.dart';
import 'sliver_bar.dart';

class IntelligentTab<T extends QueryModel> extends StatelessWidget {
  final String title;
  final Widget body;

  IntelligentTab({
    @required this.title,
    this.body,
  });

  Future<Null> _onRefresh(BuildContext context, T model) {
    Completer<Null> completer = Completer<Null>();
    model.refreshData().then((_) {
      if (model.loadingFailed)
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('No internet connection, cannot reload.'),
            action: SnackBarAction(
              label: 'RELOAD',
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
              key: PageStorageKey(title),
              slivers: <Widget>[
                SliverBar(
                  title: title,
                  header: model.isLoading
                      ? LoadingIndicator()
                      : model.loadingFailed && model.photos.isEmpty
                          ? SizedBox()
                          : SwiperHeader(list: model.photos),
                  actions: <Widget>[
                    PopupMenuButton<String>(
                      itemBuilder: (context) => Menu.home.keys
                          .map((string) => PopupMenuItem(
                                value: string,
                                child: Text(
                                    FlutterI18n.translate(context, string)),
                              ))
                          .toList(),
                      onSelected: (text) =>
                          Navigator.pushNamed(context, Menu.home[text]),
                    ),
                  ],
                ),
                model.isLoading
                    ? SliverFillRemaining(child: LoadingIndicator())
                    : model.loadingFailed && model.items.isEmpty
                        ? SliverFillRemaining(child: Icon(Icons.toc))
                        : body,
              ],
            ),
          ),
    );
  }
}

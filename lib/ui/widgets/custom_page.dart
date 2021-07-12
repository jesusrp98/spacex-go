import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

import 'index.dart';

typedef RequestListBuilderLoaded<T> = List<Widget> Function(
  BuildContext context,
  RequestState<T> state,
  T value,
);

/// Basic screen, which includes an [AppBar] widget.
/// Used when the desired page doesn't have slivers or reloading.
class SimplePage extends StatelessWidget {
  final String title;
  final Widget body, fab;
  final List<Widget> actions;

  const SimplePage({
    @required this.title,
    @required this.body,
    this.fab,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: actions,
      ),
      body: body,
      floatingActionButton: fab,
    );
  }
}

/// Basic page which has reloading properties.
/// It uses the [SimplePage] widget inside it.
///
/// This page also has state control via a `RequestCubit` parameter.
class RequestSimplePage<C extends RequestCubit, T> extends StatelessWidget {
  final String title;
  final Widget fab;
  final RequestWidgetBuilderLoaded<T> childBuilder;
  final List<Widget> actions;

  const RequestSimplePage({
    @required this.title,
    @required this.childBuilder,
    this.fab,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<C>().loadData(),
      child: SimplePage(
        title: title,
        fab: fab,
        actions: actions,
        body: RequestBuilder<C, T>(
          onInit: (context, state) => Separator.none(),
          onLoading: (context, state, value) => LoadingView(),
          onLoaded: childBuilder,
          onError: (context, state, error) => ErrorView<C>(),
        ),
      ),
    );
  }
}

/// This page is similar to `SimplePage`, in regards that it doesn't control state.
/// It holds a `SliverAppBar` and a plethera of others slivers inside.
class SliverPage extends StatelessWidget {
  final String title;
  final Widget header;
  final List<Widget> children, actions;
  final Map<String, String> popupMenu;
  final ScrollController controller;

  const SliverPage({
    @required this.title,
    @required this.header,
    this.children,
    this.actions,
    this.popupMenu,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey(title),
      controller: controller,
      slivers: <Widget>[
        SliverBar(
          title: title,
          header: header,
          actions: <Widget>[
            if (popupMenu != null)
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  for (final item in popupMenu.keys)
                    PopupMenuItem(
                      value: item,
                      child: Text(FlutterI18n.translate(context, item)),
                    )
                ],
                onSelected: (text) =>
                    Navigator.pushNamed(context, popupMenu[text]),
                icon: IconShadow(Icons.adaptive.more),
              ),
            if (actions != null) ...actions,
          ],
        ),
        ...children,
      ],
    );
  }
}

/// Basic slivery page which has reloading properties.
/// It uses the [SliverPage] widget inside it.
///
/// This page also has state control via a `RequestCubit` parameter.
class RequestSliverPage<C extends RequestCubit, T> extends StatelessWidget {
  final String title;
  final RequestWidgetBuilderLoaded<T> headerBuilder;
  final RequestListBuilderLoaded<T> childrenBuilder;
  final List<Widget> actions;
  final Map<String, String> popupMenu;
  final ScrollController controller;

  const RequestSliverPage({
    @required this.title,
    @required this.headerBuilder,
    @required this.childrenBuilder,
    this.controller,
    this.actions,
    this.popupMenu,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<C>().loadData(),
      child: RequestBuilder<C, T>(
        onInit: (context, state) => SliverPage(
          controller: controller,
          title: title,
          header: Separator.none(),
          actions: actions,
          popupMenu: popupMenu,
        ),
        onLoading: (context, state, value) => SliverPage(
          controller: controller,
          title: title,
          header: value != null
              ? headerBuilder(context, state, value)
              : Separator.none(),
          actions: actions,
          popupMenu: popupMenu,
          children: value != null
              ? childrenBuilder(context, state, value)
              : [LoadingSliverView()],
        ),
        onLoaded: (context, state, value) => SliverPage(
          controller: controller,
          title: title,
          header: headerBuilder(context, state, value),
          actions: actions,
          popupMenu: popupMenu,
          children: childrenBuilder(context, state, value),
        ),
        onError: (context, state, error) => SliverPage(
          controller: controller,
          title: title,
          header: Separator.none(),
          actions: actions,
          popupMenu: popupMenu,
          // ignore: prefer_const_literals_to_create_immutables
          children: [ErrorSliverView<C>()],
        ),
      ),
    );
  }
}

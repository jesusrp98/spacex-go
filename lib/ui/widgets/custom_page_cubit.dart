import 'dart:async';

import 'package:big_tip/big_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

import '../../cubits/base/index.dart';
import 'index.dart';

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
// class ReloadableSimplePage<C extends RequestCubit, T> extends StatelessWidget {
//   final String title;
//   final Widget body, fab;
//   final List<Widget> actions;

//   const ReloadableSimplePage({
//     @required this.title,
//     @required this.body,
//     this.fab,
//     this.actions,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SimplePage(
//       title: title,
//       fab: fab,
//       actions: actions,
//       body: RefreshIndicator(
//         onRefresh: () => null,
//         child: RequestBuilder<C, T>(
//           onLoading: (_, __) => _LoadingView(),
//           onLoaded: (_, __, ___) => SafeArea(
//             bottom: false,
//             child: body,
//           ),
//           onError: (_, __, ___) => _ErrorView<C>(),
//         ),
//       ),
//     );
//   }
// }

/// This widget is used for all tabs inside the app.
/// Its main features are connection error handeling,
/// pull to refresh, as well as working as a sliver list.
class SliverPage extends StatelessWidget {
  final String title;
  final Widget header;
  final List<Widget> children, actions;
  final Map<String, String> popupMenu;

  const SliverPage({
    @required this.title,
    @required this.header,
    this.children,
    this.actions,
    this.popupMenu,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey(title),
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
              ),
            if (actions != null) ...actions,
          ],
        ),
        ...children,
      ],
    );
  }
}

class RequestSliverPage<C extends RequestCubit, T> extends StatelessWidget {
  final String title;
  final RequestWidgetBuilderLoaded<T> headerBuilder;
  final RequestListBuilderLoaded<T> childrenBuilder;
  final List<Widget> actions;
  final Map<String, String> popupMenu;
  final void Function() onRefresh;

  const RequestSliverPage({
    @required this.title,
    @required this.headerBuilder,
    @required this.childrenBuilder,
    this.actions,
    this.popupMenu,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final onRefreshFunction = onRefresh ?? () => context.read<C>().loadData();
    return RefreshIndicator(
      onRefresh: onRefreshFunction,
      child: RequestBuilder<C, T>(
        onInit: (context, state) => SliverPage(
          title: title,
          header: Separator.none(),
          actions: actions,
          popupMenu: popupMenu,
        ),
        onLoading: (context, state) => SliverPage(
          title: title,
          header: _LoadingView(),
          actions: actions,
          popupMenu: popupMenu,
          children: [_LoadingSliverView()],
        ),
        onLoaded: (context, state, value) => SliverPage(
          title: title,
          header: headerBuilder(context, state, value),
          actions: actions,
          popupMenu: popupMenu,
          children: childrenBuilder(context, state, value),
        ),
        onError: (context, state, error) => SliverPage(
          title: title,
          header: Separator.none(),
          actions: actions,
          popupMenu: popupMenu,
          children: [_ErrorSliverView<C>(onRefreshFunction)],
        ),
      ),
    );
  }
}

class _ErrorSliverView<C extends RequestCubit> extends StatelessWidget {
  final void Function() onRefresh;

  const _ErrorSliverView(this.onRefresh, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BigTip(
      subtitle: Text(
        FlutterI18n.translate(
          context,
          'spacex.other.loading_error.message',
        ),
        // style:
        //     GoogleFonts.rubikTextTheme(Theme.of(context).textTheme).subtitle1,
      ),
      action: Text(
        FlutterI18n.translate(
          context,
          'spacex.other.loading_error.reload',
        ),
        // style: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
        //     .subtitle1
        //     .copyWith(
        //       color: Theme.of(context).accentColor,
        //       fontWeight: FontWeight.bold,
        //     ),
      ),
      actionCallback: onRefresh,
      child: Icon(Icons.cloud_off),
    );
  }
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
}

class _LoadingSliverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: _LoadingView(),
    );
  }
}

Future<void> _onRefresh<C extends RequestCubit>(BuildContext context) {
  final Completer<void> completer = Completer<void>();
  final cubit = context.watch<C>();

  cubit.loadData().then((_) {
    if (cubit.state.status == RequestStatus.error) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
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
              onPressed: () => _onRefresh<C>(context),
            ),
          ),
        );
    }
    completer.complete();
  });

  return completer.future;
}

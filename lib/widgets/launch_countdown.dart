import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:row_collection/row_collection.dart';

import '../models/launch.dart';

/// LAUNCH COUNTDOWN WIDGET
/// Stateful widget used to display a countdown to the next launch.
class LaunchCountdown extends StatefulWidget {
  final Launch launch;

  LaunchCountdown(this.launch);
  State createState() => _LaunchCountdownState();
}

class _LaunchCountdownState extends State<LaunchCountdown>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.launch.launchDate.millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch,
      ),
    );
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      animation: StepTween(
        begin: widget.launch.launchDate.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch,
      ).animate(_controller),
      launchDate: widget.launch.launchDate,
      name: widget.launch.name,
      url: widget.launch.getVideo,
    );
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;
  final DateTime launchDate;
  final String name, url;

  Countdown({
    Key key,
    this.animation,
    this.launchDate,
    this.name,
    this.url,
  }) : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    return launchDate.isAfter(DateTime.now())
        ? Text(
            getTimer(launchDate.difference(DateTime.now())),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontFamily: 'RobotoMono'),
          )
        : InkWell(
            onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: url,
                  androidToolbarColor: Theme.of(context).primaryColor,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.play_arrow, size: 30),
                Separator.smallSpacer(),
                Text(
                  FlutterI18n.translate(
                    context,
                    'spacex.home.tab.live_mission',
                  ).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontFamily: 'RobotoMono'),
                ),
              ],
            ),
          );
  }

  String getTimer(Duration d) =>
      'T-' +
      d.inDays.toString().padLeft(2, '0') +
      'd:' +
      (d.inHours - d.inDays * Duration.hoursPerDay).toString().padLeft(2, '0') +
      'h:' +
      (d.inMinutes -
              d.inDays * Duration.minutesPerDay -
              (d.inHours - d.inDays * Duration.hoursPerDay) *
                  Duration.minutesPerHour)
          .toString()
          .padLeft(2, '0') +
      'm:' +
      (d.inSeconds % 60).toString().padLeft(2, '0') +
      's';
}

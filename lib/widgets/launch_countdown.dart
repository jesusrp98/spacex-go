import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
    );
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;
  final DateTime launchDate;
  final String name;

  const Countdown({
    Key key,
    this.animation,
    this.launchDate,
    this.name,
  }) : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    Duration _launchDateDiff = launchDate.difference(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _countdownChild(
          context: context,
          title: getTimer(_launchDateDiff.inDays),
          description: FlutterI18n.translate(
            context,
            'spacex.home.tab.counter.day',
          ),
        ),
        Separator.spacer(),
        _countdownChild(
          context: context,
          title: getTimer(_launchDateDiff.inHours),
          description: FlutterI18n.translate(
            context,
            'spacex.home.tab.counter.hour',
          ),
        ),
        Separator.spacer(),
        _countdownChild(
          context: context,
          title: getTimer(_launchDateDiff.inMinutes),
          description: FlutterI18n.translate(
            context,
            'spacex.home.tab.counter.min',
          ),
        ),
        Separator.spacer(),
        _countdownChild(
          context: context,
          title: getTimer(_launchDateDiff.inSeconds),
          description: FlutterI18n.translate(
            context,
            'spacex.home.tab.counter.sec',
          ),
        ),
      ],
    );
  }

  Widget _countdownChild({
    BuildContext context,
    String title,
    String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _countdownText(context: context, text: title, fontSize: 40),
        _countdownText(context: context, text: description, fontSize: 15),
      ],
    );
  }

  Widget _countdownText({BuildContext context, double fontSize, String text}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'RobotoMono',
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0, 0),
            blurRadius: 4,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  String getTimer(int time) {
    if (time > Duration.secondsPerDay)
      return ((time % 60) ~/ 10).toString() + ((time % 60) % 10).toString();
    else if (time > Duration.minutesPerDay)
      return ((time % 60) ~/ 10).toString() + ((time % 60) % 10).toString();
    else if (time > Duration.hoursPerDay)
      return ((time % 24) ~/ 10).toString() + ((time % 24) % 10).toString();
    else
      return time.toString().padLeft(2, '0');
  }
}

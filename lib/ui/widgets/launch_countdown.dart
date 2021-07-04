import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_collection/row_collection.dart';

import '../../utils/translate.dart';

/// Stateful widget used to display a countdown to the next launch.
class LaunchCountdown extends StatefulWidget {
  final DateTime launchDate;

  const LaunchCountdown(this.launchDate);

  @override
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
        seconds: widget.launchDate.millisecondsSinceEpoch -
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
        begin: widget.launchDate.millisecondsSinceEpoch,
        end: DateTime.now().millisecondsSinceEpoch,
      ).animate(_controller),
      launchDate: widget.launchDate,
    );
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;
  final DateTime launchDate;

  const Countdown({
    Key key,
    this.animation,
    this.launchDate,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Duration _launchDateDiff = launchDate.difference(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _countdownChild(
          context: context,
          title: _launchDateDiff.inDays.toString().padLeft(2, '0'),
          description: context.translate('spacex.home.tab.counter.day'),
        ),
        Separator.spacer(),
        _countdownChild(
          context: context,
          title: digitsToString(
            (_launchDateDiff.inHours % 24) ~/ 10,
            (_launchDateDiff.inHours % 24) % 10,
          ),
          description: context.translate('spacex.home.tab.counter.hour'),
        ),
        Separator.spacer(),
        _countdownChild(
          context: context,
          title: digitsToString(
            (_launchDateDiff.inMinutes % 60) ~/ 10,
            (_launchDateDiff.inMinutes % 60) % 10,
          ),
          description: context.translate('spacex.home.tab.counter.min'),
        ),
        Separator.spacer(),
        _countdownChild(
          context: context,
          title: digitsToString(
            (_launchDateDiff.inSeconds % 60) ~/ 10,
            (_launchDateDiff.inSeconds % 60) % 10,
          ),
          description: context.translate('spacex.home.tab.counter.sec'),
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
        _countdownText(context: context, text: title, fontSize: 42),
        _countdownText(context: context, text: description, fontSize: 16),
      ],
    );
  }

  Widget _countdownText({BuildContext context, double fontSize, String text}) {
    return Text(
      text,
      style: GoogleFonts.robotoMono(
        fontSize: fontSize,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 4,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  String digitsToString(int digit0, int digit1) =>
      digit0.toString() + digit1.toString();
}

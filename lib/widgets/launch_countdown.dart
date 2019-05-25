import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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

  Countdown({
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _columnItem(getTimer(_launchDateDiff.inDays), "spacex.home.tab.counter.day", context),
                _columnItem(getTimer(_launchDateDiff.inHours), "spacex.home.tab.counter.hour", context),
                _columnItem(getTimer(_launchDateDiff.inMinutes), "spacex.home.tab.counter.min", context),
                _columnItem(getTimer(_launchDateDiff.inSeconds), "spacex.home.tab.counter.sec", context),
              ],
            );
  }

  Widget _columnItem (String value, String descriptionValue, BuildContext context){
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _countItem(value, Theme.of(context).textTheme.headline.fontSize, context),
              _countItem(
                FlutterI18n.translate(
                    context,
                    descriptionValue,
                ), 
                Theme.of(context).textTheme.overline.fontSize,
                context
              ),
            ],
          );
  }

  Widget _countItem (String value, double textSize, BuildContext context){
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        child: Text(
                value,
                style:  TextStyle(
                          fontSize: textSize,  
                          color: Colors.white,
                          fontFamily: 'RobotoMono', 
                        ),
              ),
        decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.60),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
      );
  }

  String getTimer(int time) {

    if (time > Duration.secondsPerDay) {
     return ((time % 60)~/ 10).toString() + ((time % 60) % 10).toString();
    }
    else if (time > Duration.minutesPerDay){
      return ((time % 60)~/ 10).toString() + ((time % 60) % 10).toString();
    }
    else if (time > Duration.hoursPerDay){
      return ((time % 24) ~/ 10).toString() + ((time % 24) % 10).toString();
    }
    else {
      return time.toString();
    }
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

class _Image extends StatelessWidget {
  final String url;
  final VoidCallback onTap;
  final double maxRadius;
  final double size;

  _Image({
    this.url,
    this.maxRadius,
    this.onTap,
  }) : size = 2.0 * (maxRadius / math.sqrt2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(url),
          ),
        ),
      ),
    );
  }
}

class HeroImage {
  static const double maxSize = 150.0;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(
      {BuildContext context,
      String url,
      String tag,
      String title,
      VoidCallback onClick}) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Center(
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 6.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: maxSize * 2.0,
                    height: maxSize * 2.0,
                    child: Hero(
                      createRectTween: _createRectTween,
                      tag: tag,
                      child: _Image(
                        url: url,
                        maxRadius: maxSize,
                        onTap: onClick,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHero(
      {BuildContext context,
      double size: 72.0,
      String url,
      String tag,
      String title,
      VoidCallback onClick}) {
    return Container(
      width: size,
      height: size,
      child: Hero(
        createRectTween: _createRectTween,
        tag: tag,
        child: _Image(
          url: url,
          maxRadius: maxSize,
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder<Null>(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        child: _buildPage(
                          context: context,
                          url: url,
                          tag: tag,
                          title: title,
                          onClick: onClick,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

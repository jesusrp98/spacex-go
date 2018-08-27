import 'dart:math' as math;
import 'package:flutter/material.dart';

/// HERO IMAGE
/// Class used into building hero images & their specific hero pages.
class HeroImage {
  static const double _maxSize = 150.0;
  static const _opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  /// Method used to build the hero animation
  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  /// Builds the hero image page
  static Widget _buildPage({
    BuildContext context,
    String url,
    String tag,
    String title,
    VoidCallback onClick,
  }) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Center(
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: _maxSize * 2.0,
                    height: _maxSize * 2.0,
                    child: Hero(
                      createRectTween: _createRectTween,
                      tag: tag,
                      child:
                          _Image(url: url, maxRadius: _maxSize, onTap: onClick),
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

  /// Builds the actual hero image
  Widget buildHero({
    BuildContext context,
    double size: 72.0,
    String url,
    String tag,
    String title,
    VoidCallback onClick,
  }) {
    return Container(
      width: size,
      height: size,
      child: Hero(
        createRectTween: _createRectTween,
        tag: tag,
        child: _Image(
          url: url,
          maxRadius: _maxSize,
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder<Null>(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityCurve.transform(animation.value),
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

/// IMAGE CLASS
/// Private class which receives an image url & more to display a image network.
class _Image extends StatelessWidget {
  final String url;
  final double maxRadius;
  final VoidCallback onTap;
  final double _size;

  _Image({
    this.url,
    this.maxRadius,
    this.onTap,
  }) : _size = 2.0 * (maxRadius / math.sqrt2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: ClipRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(onTap: onTap, child: Image.network(url)),
        ),
      ),
    );
  }
}

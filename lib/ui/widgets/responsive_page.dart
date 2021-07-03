import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  final Widget child;
  final double width;
  final Size breakpoint;
  final Duration transformDuration;
  final Curve transformationCurve;

  const ResponsivePage({
    Key key,
    @required this.child,
    this.width = 560,
    this.breakpoint = const Size(600, 600),
    this.transformDuration = const Duration(milliseconds: 500),
    this.transformationCurve = Curves.easeInOutCubic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final isMobile = currentSize.width < breakpoint.width ||
        currentSize.height < breakpoint.height;

    return AnimatedContainer(
      duration: transformDuration,
      curve: transformationCurve,
      padding: isMobile
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(
              horizontal: (currentSize.width - width) / 2,
              vertical: 96,
            ),
      child: isMobile
          ? child
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: child,
            ),
    );
  }
}

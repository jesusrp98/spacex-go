import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';

class IconShadow extends StatelessWidget {
  final IconData icon;
  final EdgeInsets padding;

  const IconShadow(this.icon, {Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Center(
        child: DecoratedIcon(
          icon,
          shadows: const [
            Shadow(blurRadius: 2),
          ],
        ),
      ),
    );
  }
}

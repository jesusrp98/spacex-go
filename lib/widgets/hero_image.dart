import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final double size;
  final String url;
  final String tag;

  HeroImage({this.size, this.url, this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Hero(
        tag: tag,
        child: DecoratedBox(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  fit: BoxFit.fitWidth, image: NetworkImage(url))),
        ),
      ),
    );
  }
}

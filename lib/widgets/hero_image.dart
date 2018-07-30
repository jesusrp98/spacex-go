import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final double size;
  final String url;
  final String tag;

  HeroImage({this.size, this.url, this.tag});

  Widget getDetails(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            child: Image.network(url),
            tag: tag,
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: InkWell(
        child: Hero(
          child: Image.network(url),
          tag: tag,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => getDetails(context))),
      ),
    );
  }
}

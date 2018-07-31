import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final double size;
  final String url;
  final String tag;
  final String name;

  HeroImage({this.size, this.url, this.tag, this.name});

  Widget getDetails(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                child: Image.network(url),
                tag: tag,
              ),
              SizedBox(
                height: 32.0,
              ),
              Text(name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold))
            ],
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

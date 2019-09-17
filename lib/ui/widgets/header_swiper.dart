import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';

import '../../data/models/index.dart';
import 'index.dart';

/// Used as a sliver header, in the [background] parameter.
/// It allows the user to scroll throug multiple shots.
class SwiperHeader extends StatelessWidget {
  final List list;
  final IndexedWidgetBuilder builder;

  const SwiperHeader({
    @required this.list,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    // Return the image list, with the desire image quality
    final List auxList = selectQuality(context);

    return Swiper(
      itemCount: list.length,
      itemBuilder: builder ?? (context, index) => CacheImage(auxList[index]),
      curve: Curves.easeInOutCubic,
      autoplayDelay: 5000,
      autoplay: true,
      duration: 850,
      onTap: (index) => FlutterWebBrowser.openWebPage(
        url: auxList[index],
        androidToolbarColor: Theme.of(context).primaryColor,
      ),
    );
  }

  List selectQuality(BuildContext context) {
    // Reg exps to check if the image URL is from Flickr
    final RegExp qualityRegEx = RegExp(r'(_[a-z])*\.jpg$');
    final RegExp flickrRegEx = RegExp(
      r'^https:\/\/.+\.staticflickr\.com\/[0-9]+\/[0-9]+_.+_.+\.jpg$',
    );

    // Getting the desire image quality tag
    final int qualityIndex = ImageQuality.values
        .indexOf(Provider.of<AppModel>(context).imageQuality);
    final String qualityTag = ['_n', '', '_c'][qualityIndex];

    return list
        .map(
          (url) => flickrRegEx.hasMatch(url)
              ? url.replaceFirst(qualityRegEx, '$qualityTag.jpg')
              : url,
        )
        .toList();
  }
}

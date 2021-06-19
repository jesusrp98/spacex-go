import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../../cubits/index.dart';
import '../../utils/index.dart';

/// Used as a sliver header, in the [background] parameter.
/// It allows the user to scroll through multiple shots.
class SwiperHeader extends StatefulWidget {
  final List<String> list;
  final IndexedWidgetBuilder builder;

  const SwiperHeader({
    Key key,
    @required this.list,
    this.builder,
  }) : super(key: key);

  @override
  _SwiperHeaderState createState() => _SwiperHeaderState();
}

class _SwiperHeaderState extends State<SwiperHeader> {
  List<String> auxList;

  @override
  void initState() {
    super.initState();
    auxList = [];
  }

  @override
  void didChangeDependencies() {
    auxList = selectQuality(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: widget.list.length,
      itemBuilder:
          widget.builder ?? (context, index) => CacheImage(auxList[index]),
      curve: Curves.easeInOutCubic,
      autoplayDelay: 5000,
      autoplay: true,
      duration: 850,
      onTap: (index) => context.openUrl(auxList[index]),
    );
  }

  /// Returns the image list, with the desire image quality
  List<String> selectQuality(BuildContext context) {
    // Reg exps to check if the image URL is from Flickr
    final RegExp qualityRegEx = RegExp(r'(_[a-z])*\.jpg$');
    final RegExp flickrRegEx = RegExp(
      r'^https:\/\/.+\.staticflickr\.com\/[0-9]+\/[0-9]+_.+_.+\.jpg$',
    );

    // Getting the desire image quality tag
    final int qualityIndex = ImageQuality.values
        .indexOf(context.watch<ImageQualityCubit>().imageQuality);
    final String qualityTag = ['_w', '_z', '_b'][qualityIndex];

    return [
      for (final url in widget.list)
        flickrRegEx.hasMatch(url)
            ? url.replaceFirst(qualityRegEx, '$qualityTag.jpg')
            : url
    ];
  }
}

import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ImageQuality { low, medium, high }

/// Saves and loads information regarding the image quality setting.
class ImageQualityCubit extends HydratedCubit<ImageQuality> {
  static const defaultQuality = ImageQuality.medium;

  ImageQualityCubit() : super(defaultQuality);

  @override
  ImageQuality fromJson(Map<String, dynamic> json) {
    return ImageQuality.values[json['value']];
  }

  @override
  Map<String, int> toJson(ImageQuality state) {
    return {
      'value': state.index,
    };
  }

  ImageQuality get imageQuality => state;

  set imageQuality(ImageQuality imageQuality) => emit(imageQuality);
}

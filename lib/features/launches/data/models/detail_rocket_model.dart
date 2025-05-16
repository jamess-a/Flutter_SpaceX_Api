import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';

class DetailRocketModel extends RocketDetail {
  DetailRocketModel({
    required super.id,
    required super.name,
    required super.type,
    required super.active,
    required super.firstFlight,
    required super.country,
    required super.company,
    required super.image,
    required super.description,
  });

  factory DetailRocketModel.fromJson(Map<String, dynamic> json) {
    final images = json['flickr_images'] as List?;
    final rawImage = (images != null && images.isNotEmpty) ? images[0] : '';
    final fixedImage = DetailRocketModel._fixImgurLinkStatic(rawImage);

    return DetailRocketModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      active: json['active'] ?? '',
      firstFlight: json['first_flight'] ?? '',
      country: json['country'] ?? '',
      company: json['company'] ?? '',
      image: fixedImage,
      description: json['description'] ?? '',
    );
  }

  RocketDetail toEntity() => RocketDetail(
    id: id,
    name: name,
    type: type,
    active: active,
    firstFlight: firstFlight,
    country: country,
    company: company,
    image: image,
    description: description,
  );

  static String _fixImgurLinkStatic(String url) {
    if (url.contains('imgur.com') && !url.contains('i.imgur.com')) {
      final id = url.split('/').last.split('.').first;
      return 'https://i.imgur.com/$id.jpg';
    }
    return url;
  }
}

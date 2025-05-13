class LaunchDetail {
  final String id;
  final String name;
  final int flightNumber;
  final DateTime dateUtc;
  final String? patchImage;
  final String? webcastUrl;
  final String? wikipediaUrl;
  final bool success;
  final List<String> crewIds;
  final List<String> capsuleIds;
  final List<String> payloadIds;
  final String rocketId;
  final String launchpadId;
  final bool upcoming;
  final String? imageUrl;
  final String? youtubeId;
  final String? detail;

  const LaunchDetail({
    required this.id,
    required this.name,
    required this.flightNumber,
    required this.dateUtc,
    required this.patchImage,
    required this.webcastUrl,
    required this.wikipediaUrl,
    required this.success,
    required this.crewIds,
    required this.capsuleIds,
    required this.payloadIds,
    required this.rocketId,
    required this.launchpadId,
    required this.upcoming,
    required this.imageUrl,
    required this.youtubeId,
    required this.detail,
  });

  String? get youtubeThumbnail =>
      youtubeId != null
          ? 'https://img.youtube.com/vi/$youtubeId/hqdefault.jpg'
          : null;
}

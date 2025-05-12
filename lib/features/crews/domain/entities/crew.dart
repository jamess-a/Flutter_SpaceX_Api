class Crew {
  final String id;
  final String name;
  final String agency;
  final String imageUrl;
  final String? wikipediaUrl;
  final List<String> launches;
  final String status;

  Crew({
    required this.id,
    required this.name,
    required this.agency,
    required this.imageUrl,
    required this.wikipediaUrl,
    required this.launches,
    required this.status,
  });
}

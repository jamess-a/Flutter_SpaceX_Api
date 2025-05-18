import 'package:flutter/material.dart';
import 'package:spacex/core/presentation/widgets/detail_title.dart';
import 'package:spacex/features/launches/domain/entities/launchpad_detail.dart';

class LaunchpadDetailSection extends StatelessWidget {
  final LaunchPadDetail? launchpad;

  const LaunchpadDetailSection({super.key, required this.launchpad});

  @override
  Widget build(BuildContext context) {
    if (launchpad == null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Divider(),
            Icon(Icons.rocket_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              "Launchpad info is not available.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Divider(),
          ],
        ),
      );
    }

    final hasImages = launchpad!.images.isNotEmpty;
    final imageUrl = hasImages ? launchpad!.images : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Row(
            children: const [
              Icon(Icons.rounded_corner, color: Colors.blueAccent),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Launchpad Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: hasImages ? null : const Color.fromARGB(255, 27, 56, 220),
              image:
                  hasImages
                      ? DecorationImage(
                        image: NetworkImage(launchpad!.images[0]),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          debugPrint("Image load failed: $exception");
                        },
                      )
                      : null,
            ),
            child:
                hasImages
                    ? null
                    : const Center(
                      child: Icon(
                        Icons.rounded_corner,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
          ),
          const SizedBox(height: 10),
          InfoTile(label: 'Name', value: launchpad!.name),
          InfoTile(label: 'Status', value: launchpad!.status),
          InfoTile(label: 'Location', value: launchpad!.region),
          InfoTile(label: 'Latitude', value: launchpad!.latitude.toString()),
          InfoTile(label: 'Longitude', value: launchpad!.longitude.toString()),
          const Divider(),
        ],
      ),
    );
  }
}

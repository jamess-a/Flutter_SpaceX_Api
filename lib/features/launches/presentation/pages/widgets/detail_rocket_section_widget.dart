import 'package:flutter/material.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';
import 'package:spacex/core/theme/app_color.dart';

class RocketDetailSection extends StatelessWidget {
  final RocketDetail? rocket;

  const RocketDetailSection({super.key, this.rocket});

  @override
  Widget build(BuildContext context) {
    if (rocket! == null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Divider(),
            Icon(Icons.rocket_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              "Rocket info is not available.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Divider(),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Row(
            children: const [
              Icon(Icons.rocket_launch, color: Colors.blueAccent),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Rocket Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            height: 200, 
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color:
                  rocket?.image.isEmpty ?? true
                      ? const Color.fromARGB(255, 27, 56, 220)
                      : null,
              image:
                  (rocket?.image.isNotEmpty ?? false)
                      ? DecorationImage(
                        image: NetworkImage(rocket!.image),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          debugPrint("Image load failed: $exception");
                        },
                      )
                      : null,
            ),
            child:
                (rocket?.image.isEmpty ?? true)
                    ? const Center(
                      child: Icon(
                        Icons.rocket_launch,
                        size: 48,
                        color: Colors.white,
                      ),
                    )
                    : null,
          ),

          const SizedBox(height: 10),
          _infoTile("Name", rocket!.name),
          _infoTile("Type", rocket!.type),
          _infoTile("Company", rocket!.company),
          _infoTile("firstFlight", rocket!.firstFlight),
          _infoTile("Country", rocket!.country),
          const Divider(),
          _infoTile("Description", rocket!.description),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

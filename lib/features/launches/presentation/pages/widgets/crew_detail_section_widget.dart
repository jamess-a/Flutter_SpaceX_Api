import 'package:flutter/material.dart';
import 'package:spacex/features/launches/domain/entities/crew_detail.dart';

class CrewsDetailSection extends StatelessWidget {
  final List<CrewDetail?> crews;

  const CrewsDetailSection({super.key, required this.crews});

  @override
  Widget build(BuildContext context) {
    final filteredCrews = crews.whereType<CrewDetail>().toList();

    if (filteredCrews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Divider(),
            Icon(Icons.people, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              "Crews info is not available.",
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
              Icon(Icons.people_alt_outlined, color: Colors.blueAccent),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Crew Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filteredCrews.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final crew = filteredCrews[index];

                return SizedBox(
                  width: 200,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: crew.imageUrl.isNotEmpty
                              ? Image.network(
                                  crew.imageUrl,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 150,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image, size: 48),
                                  ),
                                )
                              : Container(
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.person, size: 48, color: Colors.grey),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                crew.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                crew.agency,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "Status: ${crew.status}",
                                style: TextStyle(
                                  color: crew.status.toLowerCase() == "active"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

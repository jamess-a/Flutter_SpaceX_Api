import 'package:flutter/material.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:url_launcher/url_launcher.dart';

void showLaunchModalBottomSheet(BuildContext context, LaunchDetail launch) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        maxChildSize: 1.0,
        minChildSize: 0.5,
        builder: (_, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Text(
                    launch.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Flight #${launch.flightNumber}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    '📅 ${launch.dateUtc.toLocal()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    launch.upcoming ? "🚀 Upcoming" : (launch.success ? "✅ Successful" : "❌ Failed"),
                    style: TextStyle(
                      color: launch.upcoming
                          ? Colors.orange
                          : launch.success
                              ? Colors.green
                              : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Image
                if (launch.imageUrl != null)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        launch.imageUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Rocket & Launchpad
                Text("🚀 Rocket ID: ${launch.rocketId}"),
                Text("📍 Launchpad ID: ${launch.launchpadId}"),
                const SizedBox(height: 10),

                // Related IDs
                if (launch.crewIds.isNotEmpty)
                  Text("👨‍🚀 Crew: ${launch.crewIds.join(', ')}"),
                if (launch.capsuleIds.isNotEmpty)
                  Text("🛰️ Capsules: ${launch.capsuleIds.join(', ')}"),
                if (launch.payloadIds.isNotEmpty)
                  Text("📦 Payloads: ${launch.payloadIds.join(', ')}"),

                const SizedBox(height: 20),

                // External links
                if (launch.webcastUrl != null || launch.wikipediaUrl != null || launch.youtubeId != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🔗 External Links",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (launch.webcastUrl != null)
                        TextButton.icon(
                          icon: const Icon(Icons.live_tv),
                          label: const Text("Watch Webcast"),
                          onPressed: () => _launchUrl(launch.webcastUrl!),
                        ),
                      if (launch.wikipediaUrl != null)
                        TextButton.icon(
                          icon: const Icon(Icons.book),
                          label: const Text("Read on Wikipedia"),
                          onPressed: () => _launchUrl(launch.wikipediaUrl!),
                        ),
                      if (launch.youtubeId != null)
                        TextButton.icon(
                          icon: const Icon(Icons.ondemand_video),
                          label: const Text("Watch on YouTube"),
                          onPressed: () => _launchUrl('https://youtube.com/watch?v=${launch.youtubeId}'),
                        ),
                    ],
                  ),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

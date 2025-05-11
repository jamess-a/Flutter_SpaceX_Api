import 'package:flutter/material.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/localization/strings_base.dart';
import 'package:url_launcher/url_launcher.dart';

void showLaunchModalBottomSheet(
  BuildContext context,
  LaunchDetail launch,
  Strings strings,
) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(launch.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                launch.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.dustyPurple,
                              borderRadius: BorderRadius.all(
                                Radius.circular(22),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Flight #${launch.flightNumber}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Badge(
                                label: Text(
                                  'Status',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.dustyPurple,
                              ),
                              SizedBox(width: 5),
                              Text(
                                launch.upcoming
                                    ? "🚀 Upcoming"
                                    : (launch.success
                                        ? strings.launches.success
                                        : strings.launches.failed),
                                style: TextStyle(
                                  color:
                                      launch.upcoming
                                          ? Colors.orange
                                          : launch.success
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                icon: const Icon(Icons.open_in_new),
                                label: const Text("Watch on YouTube"),
                                onPressed:
                                    () => _launchUrl(
                                      'https://youtube.com/watch?v=${launch.youtubeId}',
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    '${launch.dateUtc.toLocal()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

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

// Rocket & Launchpad
                // Text("🚀 Rocket ID: ${launch.rocketId}"),
                // Text("📍 Launchpad ID: ${launch.launchpadId}"),
                // // Related IDs
                // if (launch.crewIds.isNotEmpty)
                //   Text("👨‍🚀 Crew: ${launch.crewIds.join(', ')}"),
                // if (launch.capsuleIds.isNotEmpty)
                //   Text("🛰️ Capsules: ${launch.capsuleIds.join(', ')}"),
                // if (launch.payloadIds.isNotEmpty)
                //   Text("📦 Payloads: ${launch.payloadIds.join(', ')}"),

//                  Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "🔗 External Links",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       if (launch.webcastUrl != null)
//                         TextButton.icon(
//                           icon: const Icon(Icons.live_tv),
//                           label: const Text("Watch Webcast"),
//                           onPressed: () => _launchUrl(launch.webcastUrl!),
//                         ),
//                       if (launch.wikipediaUrl != null)
//                         TextButton.icon(
//                           icon: const Icon(Icons.book),
//                           label: const Text("Read on Wikipedia"),
//                           onPressed: () => _launchUrl(launch.wikipediaUrl!),
//                         ),
//                       if (launch.youtubeId != null)
//                         TextButton.icon(
//                           icon: const Icon(Icons.ondemand_video),
//                           label: const Text("Watch on YouTube"),
//                           onPressed: () => _launchUrl('https://youtube.com/watch?v=${launch.youtubeId}'),
//                         ),
//                     ],
//                   ),

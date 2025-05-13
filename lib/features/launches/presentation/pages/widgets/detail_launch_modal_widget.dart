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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: width * 0.25,
                        height: height * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          image:
                              launch.imageUrl != null
                                  ? DecorationImage(
                                    image: NetworkImage(launch.imageUrl!),
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                          color:
                              launch.imageUrl == null
                                  ? AppColors.slateBlue
                                  : null,
                        ),
                        child:
                            launch.imageUrl == null
                                ? Center(child: Icon(Icons.rocket_launch))
                                : null,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            launch.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.gray,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Badge(
                                    label: Text(
                                      'Status',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: AppColors.gray,
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
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Badge(
                                    label: Text(
                                      'Upcoming',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: AppColors.gray,
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    child:
                                        launch.upcoming
                                            ? Icon(
                                              Icons.access_time_outlined,
                                              color: Colors.orange,
                                            )
                                            : (launch.success
                                                ? Icon(
                                                  Icons.rocket_launch_sharp,
                                                  color: Colors.green,
                                                )
                                                : Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                  ],
                ),
                //-------------------------------- Date
                Center(
                  child: Text(
                    '${launch.dateUtc.toLocal()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Divider(),
                //------------------------------- Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child:
                      launch.youtubeThumbnail != null
                          ? Image.network(
                            launch.youtubeThumbnail!,
                            width: width * 0.98,
                            height: height * 0.25,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: width * 0.98,
                                height: height * 0.25,
                                color: AppColors.slateBlue,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: width * 0.98,
                                height: height * 0.25,
                                color: AppColors.slateBlue,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          )
                          : Container(
                            width: width * 0.98,
                            height: height * 0.25,
                            color: AppColors.slateBlue,
                          ),
                ),
                const Divider(),
                //------------------------------- Description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Badge(
                        label: Text(
                          'Description',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: AppColors.gray,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${launch.detail != '' ? launch.detail : 'No description'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Badge(
                        label: Text(
                          'Extra info',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: AppColors.gray,
                      ),
                    ),
                    if (launch.wikipediaUrl != null)
                      TextButton.icon(
                        icon: const Icon(Icons.book),
                        label: const Text("Read on Wikipedia"),
                        onPressed: () => _launchUrl(launch.wikipediaUrl!),
                      ),
                    if (launch.webcastUrl != null)
                      TextButton.icon(
                        icon: const Icon(Icons.cast_connected_outlined),
                        label: const Text('Watch on Webcast'),
                        onPressed: () => _launchUrl(launch.webcastUrl!),
                      ),
                    //------------------------------- Links
                    Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ),
                  ],
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

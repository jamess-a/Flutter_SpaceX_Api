import 'package:flutter/material.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/features/launches/domain/entities/launch_detail.dart';
import 'package:spacex/features/launches/domain/entities/rocket_detail.dart';
import 'package:spacex/features/launches/presentation/pages/widgets/detail_rocket_section_widget.dart';
import 'package:spacex/localization/strings_base.dart';
import 'package:url_launcher/url_launcher.dart';

void showLaunchModalBottomSheet(
  BuildContext context,
  LaunchDetail launch,
  RocketDetail rocket,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: width * 0.35,
                        height: height * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
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
                                ? const Center(child: Icon(Icons.rocket_launch))
                                : null,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ), // เว้นช่องว่างระหว่างรูปกับข้อความ
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              launch.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppColors.gray,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Flight#${launch.flightNumber ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Badge(
                                label: Text(
                                  'Status',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.gray,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  launch.upcoming
                                      ? "🚀 Upcoming"
                                      : (launch.success
                                          ? strings.launches.success
                                          : strings.launches.failed),
                                  style: TextStyle(
                                    color:
                                        launch.upcoming
                                            ? Colors.orange
                                            : (launch.success
                                                ? Colors.green
                                                : Colors.red),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Badge(
                                label: Text(
                                  'Upcoming',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.gray,
                              ),
                              const SizedBox(width: 5),
                              launch.upcoming
                                  ? const Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.orange,
                                  )
                                  : launch.success == true
                                  ? const Icon(
                                    Icons.rocket_launch_sharp,
                                    color: Colors.green,
                                  )
                                  : const Icon(Icons.close, color: Colors.red),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton.icon(
                              icon: const Icon(Icons.open_in_new),
                              label: const Text("Watch on YouTube"),
                              onPressed:
                                  () => _launchUrl(
                                    'https://youtube.com/watch?v=${launch.youtubeId}',
                                  ),
                            ),
                          ),
                        ],
                      ),
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
                    RocketDetailSection(rocket: rocket),

                    //------------------------------- Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
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

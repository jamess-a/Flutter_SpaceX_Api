import 'package:flutter/material.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/localization/strings_base.dart';
import 'package:intl/intl.dart';
import 'package:spacex/features/launches/domain/entities/latest_launch.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveLaunch extends StatelessWidget {
  final Strings string;
  final LatestLaunch launch;

  const LiveLaunch({super.key, required this.string, required this.launch});

  @override
  Widget build(BuildContext context) {
    void _launchWebcast(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri , mode: LaunchMode.externalApplication);
      }
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: InkWell(
        onTap: () {
          if (launch.webcastUrl != null) {
            _launchWebcast(launch.webcastUrl!);
          }
        },
        child: Container(
          width: width * 0.98,
          height: height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image:
                launch.youtubeThumbnail != null
                    ? DecorationImage(
                      image: NetworkImage(launch.youtubeThumbnail!),
                      fit: BoxFit.cover,
                    )
                    : null,
            color: launch.youtubeThumbnail == null ? AppColors.slateBlue : null,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        launch.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat.yMMMMd().format(launch.dateUtc),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        launch.upcoming == true
                            ? string.launches.upcoming
                            : (launch.success == true
                                ? string.launches.success
                                : string.launches.failed),
                        style: TextStyle(
                          color: launch.success ? Colors.green : Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

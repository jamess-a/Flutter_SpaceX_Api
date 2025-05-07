import 'package:flutter/material.dart';
import 'package:spacex/core/theme/app_color.dart';

class LiveLaunch extends StatefulWidget {
  const LiveLaunch({super.key});

  @override
  State<LiveLaunch> createState() => _LiveLaunchState();
}

class _LiveLaunchState extends State<LiveLaunch> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: AppColors.slateBlue,
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: width * 0.96,
            height: height * 0.25,
            child: Center(child: Text('Live Launch')),
          ),
        ),
      ),
    );
  }
}

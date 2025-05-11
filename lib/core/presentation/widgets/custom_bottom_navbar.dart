import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spacex/core/theme/app_color.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key, required this.onCrewTap});

  final VoidCallback onCrewTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.slateBlue.withOpacity(0.95),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {
                    context.go('/home');
                  },
                ),
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.newspaper_outlined),
                  color: Colors.white,
                  onPressed: () {
                    // list: context.go('/news');
                  },
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.rounded_corner),
                  tooltip: 'Pads List',
                  color: Colors.white,
                  onPressed: () {
                    // list: context.go('/settings');
                  },
                ),
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.people_outline_sharp),
                  tooltip: 'Crew List',
                  color: Colors.white,
                  onPressed: onCrewTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

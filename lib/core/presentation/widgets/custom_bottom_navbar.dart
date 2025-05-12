import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spacex/core/theme/app_color.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key, required this.onCrewTap});

  final VoidCallback onCrewTap;

  @override
  Widget build(BuildContext context) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.location;

    return BottomAppBar(
      color: AppColors.slateBlue.withOpacity(0.90),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.home),
                  color:
                      currentRoute == '/home'
                          ? Colors.white54
                          : Colors.white,
                  onPressed:
                      currentRoute == '/home'
                          ? null
                          : () => context.go('/home'),
                ),
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.newspaper_outlined),
                  color:
                      currentRoute == '/news'
                          ? Colors.white54
                          : Colors.white,
                  onPressed:
                      currentRoute == '/news'
                          ? null
                          : () {
                            // context.go('/news');
                          },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.rounded_corner),
                  tooltip: 'Pads List',
                  color:
                      currentRoute == '/pads'
                          ? Colors.white54
                          : Colors.white,
                  onPressed:
                      currentRoute == '/pads'
                          ? null
                          : () {
                            // context.go('/pads');
                          },
                ),
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.people_outline_sharp),
                  tooltip: 'Crew List',
                  color:
                      currentRoute == '/crew'
                          ? Colors.white54
                          : Colors.white,
                  onPressed: currentRoute == '/crew' ? null : onCrewTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

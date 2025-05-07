import 'package:flutter/material.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/core/utils/notifications_helper.dart';
import 'package:spacex/localization/strings_base.dart';

class SearchLaunchWidget extends StatefulWidget {
  final Strings string;

  const SearchLaunchWidget({super.key, required this.string});

  @override
  State<SearchLaunchWidget> createState() => _SearchLaunchWidgetState();
}

class _SearchLaunchWidgetState extends State<SearchLaunchWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleSearch(String query) {
    if (query.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NotificationHelper.showError(
          context,
          "Please enter launch name to search",
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = widget.string;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            color: AppColors.slateBlue,
            iconSize: 35,
            icon: const Icon(Icons.search),
            onPressed: () {
              handleSearch(_controller.text);
            },
          ),
          Expanded(
            child: TextField(
              cursorColor: AppColors.lightLilac,
              controller: _controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(21)),
                  borderSide: BorderSide(color: AppColors.slateBlue),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(21)),
                ),
                labelText: strings.launches.searchHint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spacex/core/theme/app_color.dart';

class SearchLaunchWidget extends StatefulWidget {
  const SearchLaunchWidget({super.key});

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
    print(query);
  }

  @override
  Widget build(BuildContext context) {
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
                labelText: 'Launch name',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/core/utils/notifications_helper.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_List_bloc.dart';
import 'package:spacex/features/launches/presentation/bloc/launch_list_event.dart';
import 'package:spacex/localization/strings_base.dart';

class SearchLaunchWidget extends StatefulWidget {
  final Strings string;

  const SearchLaunchWidget({super.key, required this.string});

  @override
  State<SearchLaunchWidget> createState() => _SearchLaunchWidgetState();
}

class _SearchLaunchWidgetState extends State<SearchLaunchWidget> {
  late TextEditingController _controller;
  bool isNameAsc = true;
  bool isDateAsc = true;
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
      context.read<LaunchListBloc>().add(FetchLaunches());
    }
    context.read<LaunchListBloc>().add(SearchLaunches(query));
  }

  void handleSortLaunches() {
    context.read<LaunchListBloc>().add(
      SortLaunches(SortCriteria.name, ascending: isNameAsc),
    );
    setState(() {
      isNameAsc = !isNameAsc;
    });
  }

  void handleSortLaunchesByDate() {
    context.read<LaunchListBloc>().add(
      SortLaunches(SortCriteria.date, ascending: isDateAsc),
    );
    setState(() {
      isDateAsc = !isDateAsc;
    });
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = widget.string;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
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
          const SizedBox(width: 12),
          IconButton(
            color: AppColors.slateBlue,
            iconSize: 25,
            icon: const Icon(Icons.search),
            onPressed: () => handleSearch(_controller.text),
          ),
          IconButton(
            color: AppColors.slateBlue,
            iconSize: 25,
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: handleSortLaunches,
          ),
          IconButton(
            color: AppColors.slateBlue,
            iconSize: 25,
            icon: const Icon(Icons.sort_sharp),
            onPressed: handleSortLaunchesByDate,
          ),
        ],
      ),
    );
  }
}

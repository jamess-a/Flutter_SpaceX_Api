import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/theme/app_color.dart';
import 'package:spacex/features/crews/presentation/bloc/crews/crews_list_bloc.dart';
import 'package:spacex/features/crews/presentation/bloc/crews/crews_list_event.dart';
import 'package:spacex/features/launches/presentation/bloc/launches/launch_list_bloc.dart';
import 'package:spacex/features/launches/presentation/bloc/launches/launch_list_event.dart';
import 'package:spacex/localization/strings_base.dart';

class SearchCrewWidget extends StatefulWidget {
  final Strings string;

  const SearchCrewWidget({super.key, required this.string});

  @override
  State<SearchCrewWidget> createState() => _SearchLaunchWidgetState();
}

class _SearchLaunchWidgetState extends State<SearchCrewWidget> {
  late TextEditingController _controller;
  bool isNameAsc = false;
  bool isDateAsc = false;
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
      context.read<CrewsListBloc>().add(FetchCrews());
    }
    context.read<CrewsListBloc>().add(SearchCrews(query));
  }

  void handleSortCrews() {
    context.read<CrewsListBloc>().add(
      SortCrews(SortCrewsCriteria.name, ascending: isNameAsc),
    );
    setState(() {
      isNameAsc = !isNameAsc;
    });
  }

  // void handleSerch (String query) {
  //   if (query.isEmpty){
  //     context.read<CrewListBloc>().add(query);
  //   } 
  // }

  @override
  Widget build(BuildContext context) {
    Strings strings = widget.string;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Builder(
        builder:
            (context) => Row(
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
                      suffixIcon: IconButton(
                        color: AppColors.slateBlue,
                        iconSize: 25,
                        icon: const Icon(Icons.search),
                        onPressed: () => handleSearch(_controller.text),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  color: AppColors.slateBlue,
                  iconSize: 25,
                  icon: const Icon(Icons.sort_by_alpha),
                  onPressed: handleSortCrews,
                ),
              ],
            ),
      ),
    );
  }
}

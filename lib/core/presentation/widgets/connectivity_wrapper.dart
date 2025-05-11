import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/core/di/injection_container.dart' as di;
import 'package:spacex/core/network/connectivity_cubit.dart';
import 'package:spacex/features/launches/domain/usecases/use_case.dart';
import 'package:spacex/features/launches/presentation/pages/launch_list_page.dart';

class ConnectivityWrapper extends StatelessWidget {
  const ConnectivityWrapper({super.key});

  void reconnect(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Rechecking connection...')));
    context.read<ConnectivityCubit>().checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
      builder: (context, status) {
        if (status == ConnectivityStatus.checking) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (status == ConnectivityStatus.disconnected) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => reconnect(context),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reconnect'),
                  ),
                ],
              ),
            ),
          );
        }

        return LaunchListScreen(
          useCase: di.sl<GetLaunchListUseCase>(),
          latestUseCase: di.sl<GetLatestLaunchUseCase>(),
          detailUseCase: di.sl<GetDetailLaunchUseCase>(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spacex/core/network/connectivity_cubit.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  bool _navigated = false;

  void _reconnect() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rechecking connection...')),
    );
    context.read<ConnectivityCubit>().checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityStatus>(
      listener: (context, status) {
        if (status == ConnectivityStatus.connected && !_navigated) {
          _navigated = true;
          context.go('/home'); 
        }
      },
      child: BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
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
                      onPressed: _reconnect,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reconnect'),
                    ),
                  ],
                ),
              ),
            );
          }

          return widget.child;
        },
      ),
    );
  }
}

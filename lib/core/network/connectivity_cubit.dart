import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum ConnectivityStatus { connected, disconnected, checking }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  late final StreamSubscription _subscription;

  ConnectivityCubit() : super(ConnectivityStatus.connected) {
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      emit(
        status == InternetConnectionStatus.connected
            ? ConnectivityStatus.connected
            : ConnectivityStatus.disconnected,
      );
    });
  }

  Future<void> checkConnection() async {
    emit(ConnectivityStatus.checking);
    final hasConnection = await InternetConnectionChecker().hasConnection;
    emit(
      hasConnection
          ? ConnectivityStatus.connected
          : ConnectivityStatus.disconnected,
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/internet.dart';
import '../repository/connectivity_repository.dart';
import 'counter_state.dart';

enum ConnectionType { noConnectivityRepository, disconnected, connected }

class CounterCubit extends Cubit<CounterState> {
  final ConnectivityRepository? connectivityRepository;
  late final StreamSubscription<NetworkType>? connectivitySubscription;
  ConnectionType connectionType = ConnectionType.noConnectivityRepository;

  CounterCubit({this.connectivityRepository})
      : super(const CounterState(counterValue: 0)) {
    connectivitySubscription =
        connectivityRepository?.connectivityStream.listen((status) {
      if (status == NetworkType.none) {
        connectionType = ConnectionType.disconnected;
      } else if (status == NetworkType.wifi || status == NetworkType.mobile) {
        connectionType = ConnectionType.connected;
      } else {
        connectionType = ConnectionType.noConnectivityRepository;
      }
    });
  }

  void increment() {
    print('connectionType: $connectionType');
    if (connectionType == ConnectionType.noConnectivityRepository) {
      emit(CounterState(counterValue: state.counterValue + 2));
    } else if (connectionType == ConnectionType.disconnected) {
      emit(CounterState(counterValue: state.counterValue + 3));
    } else {
      emit(CounterState(counterValue: state.counterValue + 1));
    }
  }

  void decrement() {
    if (state.counterValue > 0) {
      emit(CounterState(counterValue: state.counterValue - 1));
    }
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}

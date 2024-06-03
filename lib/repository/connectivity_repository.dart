import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../constant/internet.dart';

class ConnectivityRepository {
  final Connectivity _connectivity = Connectivity();

  // Method 1:
  Stream<NetworkType> get _status async* {
    await for (final result in _connectivity.onConnectivityChanged) {
      if (result.contains(ConnectivityResult.none)) {
        yield NetworkType.none;
      } else if (result.contains(ConnectivityResult.wifi)) {
        yield NetworkType.wifi;
      } else {
        yield NetworkType.mobile;
      }
    }
  }

  // Create a broadcast stream from the status stream
  late final Stream<NetworkType> _broadcastStream = _status.asBroadcastStream();

  // Getter to access the broadcast stream
  Stream<NetworkType> get connectivityStatusStream => _broadcastStream;

  // Method 2:
  late final StreamController<NetworkType> _controller;

  ConnectivityRepository() {
    _controller = StreamController<NetworkType>.broadcast();
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        _controller.add(NetworkType.none);
      } else if (result.contains(ConnectivityResult.wifi)) {
        _controller.add(NetworkType.wifi);
      } else {
        _controller.add(NetworkType.mobile);
      }
    });
  }

  Stream<NetworkType> get connectivityStream => _controller.stream;

  Future<void> close() async {
    await _controller.close();
  }
}

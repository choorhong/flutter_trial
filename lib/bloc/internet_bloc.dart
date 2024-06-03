import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/internet.dart';
import '../repository/connectivity_repository.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final ConnectivityRepository connectivityRepository;
  late final StreamSubscription<NetworkType> connectivitySubscription;

  InternetBloc({required this.connectivityRepository})
      : super(InternetInitial()) {
    connectivitySubscription =
        connectivityRepository.connectivityStream.listen((status) {
      if (status == NetworkType.none) {
        add(InternetDisconnectedEvent());
      } else if (status == NetworkType.wifi) {
        add(const InternetConnectedEvent(connectionType: NetworkType.wifi));
      } else {
        add(const InternetConnectedEvent(connectionType: NetworkType.mobile));
      }
    });

    on<InternetConnectedEvent>((event, emit) {
      if (event.connectionType == NetworkType.wifi) {
        emit(const InternetConnected(connectionType: NetworkType.wifi));
      } else {
        emit(const InternetConnected(connectionType: NetworkType.mobile));
      }
    });

    on<InternetDisconnectedEvent>((event, emit) {
      emit(InternetDisconnected());
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }
}

// class InternetBloc extends Bloc<InternetEvent, InternetState> {
//   final Connectivity _connectivity;
//   late StreamSubscription _connectivitySubscription;

//   InternetBloc(this._connectivity) : super(InternetInitial()) {
//     on<InternetConnectedEvent>((event, emit) {
//       if (event.connectionType == NetworkType.wifi) {
//         emit(const InternetConnected(connectionType: NetworkType.wifi));
//       }
//       if (event.connectionType == NetworkType.mobile) {
//         emit(const InternetConnected(connectionType: NetworkType.mobile));
//       }
//     });

//     on<InternetDisconnectedEvent>((event, emit) {
//       emit(InternetDisconnected());
//     });

//     _connectivitySubscription = _connectivity.onConnectivityChanged
//         .listen((List<ConnectivityResult> result) {
//       if (result.contains(ConnectivityResult.mobile)) {
//         add(const InternetConnectedEvent(connectionType: NetworkType.mobile));
//       } else if (result.contains(ConnectivityResult.wifi)) {
//         add(const InternetConnectedEvent(connectionType: NetworkType.wifi));
//       } else {
//         add(InternetDisconnectedEvent());
//       }
//     });
//   }

//   @override
//   Future<void> close() {
//     _connectivitySubscription.cancel();
//     return super.close();
//   }
// }



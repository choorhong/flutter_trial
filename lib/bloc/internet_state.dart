part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

final class InternetInitial extends InternetState {}

final class InternetConnected extends InternetState {
  final NetworkType connectionType;

  const InternetConnected({required this.connectionType});

  @override
  List<Object> get props => [connectionType];
}

final class InternetDisconnected extends InternetState {}

// // internet_state.dart
// import 'package:equatable/equatable.dart';

// abstract class InternetState extends Equatable {
//   const InternetState();

//   @override
//   List<Object> get props => [];
// }

// class InternetInitial extends InternetState {}

// class InternetConnected extends InternetState {}

// class InternetDisconnected extends InternetState {}
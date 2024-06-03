part of 'internet_bloc.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class InternetConnectedEvent extends InternetEvent {
  final NetworkType connectionType;

  const InternetConnectedEvent({required this.connectionType});

  @override
  List<Object> get props => [connectionType];
}

class InternetDisconnectedEvent extends InternetEvent {}

// // internet_event.dart
// import 'package:equatable/equatable.dart';

// abstract class InternetEvent extends Equatable {
//   const InternetEvent();

//   @override
//   List<Object> get props => [];
// }

// class InternetGained extends InternetEvent {}

// class InternetLost extends InternetEvent {}
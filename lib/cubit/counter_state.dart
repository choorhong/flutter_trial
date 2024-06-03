import 'dart:convert';

import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counterValue;

  const CounterState({
    required this.counterValue,
  });

  @override
  List<Object> get props => [counterValue];

  CounterState copyWith({
    int? counterValue,
  }) {
    return CounterState(
      counterValue: counterValue ?? this.counterValue,
    );
  }

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'counterValue': counterValue,
    };
  }

  factory CounterState._fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
    );
  }

  String toJson() => json.encode(_toMap());

  factory CounterState.fromJson(String source) =>
      CounterState._fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool? get stringify => true;

  @override
  String toString() {
// If you override toString in a class extending Equatable,
// your custom toString method will be used instead of the automatic string representation provided by Equatable.

// This toString method will be used for printing the object's string representation.
// This is because the toString method directly controls the string output when the object is printed or converted to a string.

// The stringify property in Equatable is useful when you don't want to manually override toString
// but still want a readable string representation for debugging purposes.
    return 'CounterState(counterValue of toString method: $counterValue)';
  }
}

// Explanation
// Encapsulation: If you want to control how the CounterState object is serialized and deserialized and ensure that these methods are only used internally within the class or library, you should make them private.
// API Simplicity: Making these methods private simplifies the public API of your class, exposing only the toJson and fromJson methods, which are more user-friendly.
// Private Methods: _toMap and _fromMap are now private methods, indicated by the underscore prefix.
// Public Methods: toJson and fromJson remain public, providing a user-friendly API for serialization and deserialization.

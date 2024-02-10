// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  final bool wasInc;
  const CounterState({
    required this.counter,
    required this.wasInc,
  });

  @override
  List<Object?> get props => [counter, wasInc];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counter': counter,
      'wasInc': wasInc,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counter: map['counter'] as int,
      wasInc: map['wasInc'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source) as Map<String, dynamic>);

  CounterState copyWith({
    int? counter,
    bool? wasInc,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
      wasInc: wasInc ?? this.wasInc,
    );
  }
}

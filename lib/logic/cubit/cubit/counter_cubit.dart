import 'dart:developer';

import 'package:bloc_counter_app/logic/cubit/cubit/counter_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterCubit extends HydratedCubit<CounterState> {
  CounterCubit() : super(const CounterState(wasInc: false, counter: 0));
  void inc() => emit(CounterState(wasInc: true, counter: state.counter + 1));
  void dec() => emit(CounterState(wasInc: false, counter: state.counter - 1));
  void set({required int value}) =>
      emit(CounterState(wasInc: false, counter: value));

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    log(CounterState.fromMap(json).counter.toString());
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    log(state.counter.toString());
    return state.toMap();
  }
}

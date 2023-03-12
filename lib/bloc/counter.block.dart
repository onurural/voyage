import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc():super(0) {
    on<Increment>((event, emit) => increment(event, emit, state));
    on<Decrement>((event, emit) => decrement(event, emit, state));
  }

  void increment(Increment event, Emitter<int> emit, int state) {
    emit(state + 1);
  }

  void decrement(Decrement event, Emitter<int> emit, int state) {
    emit(state - 1);
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/auth/auth.event.dart';
import 'package:voyage/bloc/auth/auth.state.dart';
import 'package:voyage/repository/auth.repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnauthenticatedState()){
    on<AuthEvent>((event, emit) async {
      if (event is SignUpRequest) {
        emit(AuthLoadingState());
        try {
          await authRepository.signup(email: event.email, password: event.password);
          emit(AuthSuccessState());
        } catch (e) {
          emit(AuthFailedState());
        }
      }
    });
  }
}
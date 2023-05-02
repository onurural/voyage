

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/auth/auth.event.dart';
import 'package:voyage/bloc/auth/auth.state.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/repository/auth.repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthData();
  AuthBloc() : super(UnauthenticatedState()){
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
      if (event is LogInRequest) {
        emit(AuthLoadingState());
        try {
          await authRepository.login(email: event.email, password: event.password);
          emit(AuthSuccessState());
        } catch (e) {
          emit(AuthFailedState());
        }
      }
        if (event is SaveUserToMongoDB) {
        emit(SavingUserToMongoDB());
        try {
          await authRepository.saveUserToMongoDB(email: event.email, userId: event.userId, userName: event.userName);
          emit(SavedUserToMongoDB());
        } catch (e) {
          emit(SavingUserToMongoDBError());
        }
      }
      if (event is GetUserCredential) {
        emit(CredentialLoadingState());
        try {
          var user = await authRepository.getUserCredential(userId: event.userId);
          emit(CredentialSuccessState(user));  
        } catch (e) {
          emit(CredentialErrorState(e.toString()));
        }
        
      }
    });
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/user/user.event.dart';
import 'package:voyage/bloc/user/user.state.dart';
import 'package:voyage/data/user.data.dart';
import 'package:voyage/repository/user.repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = UserData();
  UserBloc(): super(CredentialLoadingState()) {
    on<UserEvent>((event, emit) async {
    if (event is GetUserCredential) {
        emit(CredentialLoadingState());
        try {
          var user = await userRepository.getUserCredential(userId: event.userId);
          emit(CredentialSuccessState(user));  
        } catch (e) {
          emit(CredentialErrorState(e.toString()));
        }
      }
    });
  }
}
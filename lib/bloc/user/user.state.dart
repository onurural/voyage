
import 'package:voyage/models/user.dart';

abstract class UserState {}

class CredentialLoadingState extends UserState {}
class CredentialSuccessState extends UserState {
    final User model;
    CredentialSuccessState(this.model);
}
class CredentialFailedState extends UserState {}
class CredentialErrorState extends UserState {
  final String errorMessage;
  CredentialErrorState(this.errorMessage);
}

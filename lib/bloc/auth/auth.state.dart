import 'package:voyage/models/user.dart';

abstract class AuthState {}

class UnauthenticatedState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthSuccessState extends AuthState {}
class AuthFailedState extends AuthState {}

class SavingUserToMongoDB extends AuthState {}
class SavedUserToMongoDB extends AuthState {} 
class SavingUserToMongoDBError extends AuthState {} 

class CredentialLoadingState extends AuthState {}
class CredentialSuccessState extends AuthState {
    final User model;
    CredentialSuccessState(this.model);
}
class CredentialFailedState extends AuthState {}
class CredentialErrorState extends AuthState {
  final String errorMessage;
  CredentialErrorState(this.errorMessage);
}
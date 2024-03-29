import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequest extends AuthEvent {
  final String email;
  final String password;
  SignUpRequest(this.email, this.password);
}

class LogInRequest extends AuthEvent {
    final String email;
    final String password;
    LogInRequest(this.email, this.password);
}

class SaveUserToMongoDB extends AuthEvent {
    final String email;
    final String userName;
    final String userId;
    SaveUserToMongoDB(this.email, this.userId, this.userName);
}
class ForgotPasswordRequest extends AuthEvent {
  final String email;
  ForgotPasswordRequest(this.email);
}
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
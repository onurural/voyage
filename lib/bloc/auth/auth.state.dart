abstract class AuthState {}

class UnauthenticatedState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthSuccessState extends AuthState {}
class AuthFailedState extends AuthState {}
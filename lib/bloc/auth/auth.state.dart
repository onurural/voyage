abstract class AuthState {}

class UnauthenticatedState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthSuccessState extends AuthState {}
class AuthFailedState extends AuthState {}

class SavingUserToMongoDB extends AuthState {}
class SavedUserToMongoDB extends AuthState {} 
class SavingUserToMongoDBError extends AuthState {} 


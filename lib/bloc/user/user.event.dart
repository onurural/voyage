import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchInterestedCategories extends UserEvent {
    final String userId;
    FetchInterestedCategories(this.userId);
}


class GetUserCredential extends UserEvent {
    final String userId;
    GetUserCredential(this.userId);
}

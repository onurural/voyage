import 'package:equatable/equatable.dart';

abstract class InterestedCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchInterestedCategories extends InterestedCategoryEvent {
    final String userId;
    FetchInterestedCategories(this.userId);
}

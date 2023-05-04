

import 'package:voyage/models/interested-category.dart';

abstract class InterestedCategoryState {}

class InterestedCategoryLoadingState extends InterestedCategoryState {}
class InterestedCategoryErrorState extends InterestedCategoryState {
  final String errorMessage;
  InterestedCategoryErrorState(this.errorMessage);
}
class InterestedCategorySuccessState extends InterestedCategoryState {
  final List<InterestedCategory> categories;
  InterestedCategorySuccessState(this.categories);
}
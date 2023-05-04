import 'package:voyage/models/interested-category.dart';

abstract class InterestedCategoryRepository {
  Future<List<InterestedCategory>> fetchInterestedCategories({required String userId});
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/interested-category/interested-category.event.dart';
import 'package:voyage/bloc/interested-category/interested-category.state.dart';
import 'package:voyage/data/interested-category.data.dart';
import 'package:voyage/repository/interested-category.repository.dart';


class InterestedCategoryBloc extends Bloc<InterestedCategoryEvent, InterestedCategoryState> {
  final InterestedCategoryRepository interestedCategoryRepository = InterestedCategoryData();
  InterestedCategoryBloc(): super(InterestedCategoryLoadingState()) {
    on<InterestedCategoryEvent>((event, emit) async {
      if (event is FetchInterestedCategories) {
        emit(InterestedCategoryLoadingState());
        try {
          var interestedCategories = await interestedCategoryRepository.fetchInterestedCategories(userId: event.userId);
          emit(InterestedCategorySuccessState(interestedCategories));
        } catch (e) {
          emit(InterestedCategoryErrorState(e.toString()));
        }
      }
    });
  }
}
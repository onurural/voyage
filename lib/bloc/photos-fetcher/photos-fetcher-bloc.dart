import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/photos-fetcher/photos-fetcher-event.dart';
import 'package:voyage/bloc/photos-fetcher/photos-fetcher-state.dart';

import '../../data/photos-fetcher.data.dart';

class PhotosFetcherBloc extends Bloc<PhotosFetcherEvent, PhotosFetchersState> {
  final PhotosFetcherData data;

  PhotosFetcherBloc({required this.data}) : super(PhotosFetcherInitial()) {
    on<FetchImages>((event, emit) async {
      emit(PhotosFetcherLoading());

      try {
        List<String> images = await data.fetchImages(event.location);

        if (images.isEmpty) {
          emit(PhotosFetcherError('No images found for this location.'));
        } else {
          emit(PhotosFetcherLoaded(images));
        }
      } catch (_) {
        emit(PhotosFetcherError('Failed to load images.'));
      }
    });
  }
}

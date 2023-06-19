// ignore_for_file: file_names

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
          emit(PhotosFetcherLoaded(images));
        } catch (e) {
          emit(PhotosFetcherError(e.toString()));
        }
      }
    );
  }
}

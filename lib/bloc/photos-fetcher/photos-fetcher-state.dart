abstract class PhotosFetchersState {}

class PhotosFetcherInitial extends PhotosFetchersState {}

class PhotosFetcherLoading extends PhotosFetchersState  {}

class PhotosFetcherLoaded extends PhotosFetchersState {
   final List<String> images;

  PhotosFetcherLoaded(this.images);
}

class PhotosFetcherError extends PhotosFetchersState  {
  final String message;

PhotosFetcherError(this.message);
}
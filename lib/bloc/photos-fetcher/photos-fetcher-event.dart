// ignore_for_file: file_names

abstract class PhotosFetcherEvent {}

class FetchImages extends PhotosFetcherEvent {
  final String location;

  FetchImages(this.location);
}
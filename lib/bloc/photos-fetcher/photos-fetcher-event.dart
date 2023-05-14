abstract class PhotosFetcherEvent {}

class FetchImages extends PhotosFetcherEvent {
  final String location;

  FetchImages(this.location);
}
// Define an interface for the repository.
abstract class PhotosFetcherRepository {
  Future<List<String>> fetchImages(String location);
}
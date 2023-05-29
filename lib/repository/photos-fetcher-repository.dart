// Define an interface for the repository.
// ignore_for_file: file_names

abstract class PhotosFetcherRepository {
  Future<List<String>> fetchImages(String location);
}
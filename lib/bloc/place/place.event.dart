import 'package:voyage/utility/page.enum.dart';

abstract class PlaceEvent {}

class FetchPlace extends PlaceEvent {
  late Page pageNumber;
  FetchPlace(this.pageNumber);
}

class FetchHistoricPlace extends PlaceEvent {
  late Page pageNumber;
  FetchHistoricPlace(this.pageNumber);
}

class FetchNaturalPlace extends PlaceEvent {
  late Page pageNumber;
  FetchNaturalPlace(this.pageNumber);
}

class FetchCityVibesPlace extends PlaceEvent {
  late Page pageNumber;
  FetchCityVibesPlace(this.pageNumber);
}

class FetchRuralPlace extends PlaceEvent {
  late Page pageNumber;
  FetchRuralPlace(this.pageNumber);
}

class FetchMediterrainPlace extends PlaceEvent {
  late Page pageNumber;
  FetchMediterrainPlace(this.pageNumber);
}

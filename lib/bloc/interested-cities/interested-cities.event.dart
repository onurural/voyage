import 'package:equatable/equatable.dart';

abstract class InterestedCityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchInterestedCity extends InterestedCityEvent {
  final String userId;
  FetchInterestedCity(this.userId);
}

import 'package:equatable/equatable.dart';

import 'person.dart';
import 'trip_city.dart';

class Trip extends Equatable {
  Trip({required this.cities, required this.people}) {
    for (var i = 0; i < cities.length - 1; i++) {
      assert(
        cities[i].departureDate == cities[i + 1].arrivalDate,
        '${cities[i].name} `departureDate` should be the same as ${cities[i + 1].name} `arrivalDate`.',
      );
    }
  }

  final List<TripCity> cities;
  final List<Person> people;

  @override
  List<Object?> get props => [cities, people];

  Trip copyWith({List<TripCity>? cities, List<Person>? people}) =>
      Trip(cities: cities ?? this.cities, people: people ?? this.people);
}

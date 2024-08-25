import 'package:equatable/equatable.dart';

import 'accommodation.dart';
import 'activity.dart';
import 'flight.dart';
import 'rent.dart';

class TripCity extends Equatable {
  TripCity({
    required this.name,
    this.arrivalDate,
    this.departureDate,
    this.accommodations = const [],
    this.flights = const [],
    this.activities = const [],
    this.rents = const [],
  }) : assert(
          (departureDate == null || arrivalDate == null) || departureDate.isAfter(arrivalDate),
          '`departureDate` should be after `arrivalDate`',
        );

  final String name;
  final DateTime? arrivalDate;
  final DateTime? departureDate;

  final List<Accommodation> accommodations;
  final List<Flight> flights;
  final List<Activity> activities;
  final List<Rent> rents;

  bool get areDatesSelected => arrivalDate != null && departureDate != null;

  @override
  List<Object?> get props => [
        name,
        arrivalDate,
        departureDate,
        accommodations,
        flights,
        activities,
        rents,
      ];

  TripCity copyWith({
    String? name,
    DateTime? arrivalDate,
    DateTime? departureDate,
    List<Accommodation>? accommodations,
    List<Flight>? flights,
    List<Activity>? activities,
    List<Rent>? rents,
  }) =>
      TripCity(
        name: name ?? this.name,
        arrivalDate: arrivalDate ?? this.arrivalDate,
        departureDate: departureDate ?? this.departureDate,
        accommodations: accommodations ?? this.accommodations,
        flights: flights ?? this.flights,
        activities: activities ?? this.activities,
        rents: rents ?? this.rents,
      );

  TripCity copyWithDeselectedDepartureDate() => TripCity(
        name: name,
        arrivalDate: arrivalDate,
        accommodations: accommodations,
        flights: flights,
        activities: activities,
        rents: rents,
      );

  TripCity copyWithDeselectedDates() => TripCity(
        name: name,
        accommodations: accommodations,
        flights: flights,
        activities: activities,
        rents: rents,
      );
}

part of 'trip_cubit.dart';

class TripState extends Equatable {
  const TripState({required this.trip});

  final Trip trip;

  @override
  List<Object?> get props => [trip];
}

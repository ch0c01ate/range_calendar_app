import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/trip.dart';
import '../../data/models/trip_city.dart';
import '../../utils/mock/initial_trip_data.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit() : super(TripState(trip: getInitialTripData()));

  void switchCities(List<TripCity> cities) {
    emit(TripState(trip: state.trip.copyWith(cities: cities)));
  }
}

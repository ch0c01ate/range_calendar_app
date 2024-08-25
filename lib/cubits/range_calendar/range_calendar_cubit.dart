import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/trip_city.dart';
import '../../utils/extensions/date_time_extension.dart';
import '../../utils/extensions/list_extension.dart';

part 'range_calendar_state.dart';

class RangeCalendarCubit extends Cubit<RangeCalendarState> {
  RangeCalendarCubit({required List<TripCity> initialCities})
      : super(_citiesToState(initialCities));

  static RangeCalendarState _citiesToState(List<TripCity> initialCities) {
    int selectedIndex = initialCities.length - 1;

    for (var i = 0; i < initialCities.length; i++) {
      final city = initialCities[i];

      if (city.arrivalDate != null || city.departureDate != null) {
        selectedIndex = i;
      }
    }

    return RangeCalendarState(
      firstDayOfSelectedMonth: (initialCities.first.arrivalDate ?? DateTime.now()).firstDayOfMonth,
      cities: initialCities,
      selectedCityIndex: selectedIndex,
    );
  }

  void selectNextMonth() => emit(state.copyWith(
        firstDayOfSelectedMonth: state.firstDayOfSelectedMonth.firstDayOfNextMonth,
      ));

  void selectPreviousMonth() {
    emit(state.copyWith(
      firstDayOfSelectedMonth: state.firstDayOfSelectedMonth.firstDayOfPreviousMonth,
    ));
  }

  void selectDate(DateTime date) {
    final city = state.cities[state.selectedCityIndex];
    final arrivalDate = city.arrivalDate;

    if (arrivalDate?.isSameDateAs(date) ?? false) {
      _deselectArrivalDate();
      return;
    }

    if (arrivalDate == null) {
      _selectArrivalDate(date);
    } else {
      if (date.isAfter(arrivalDate)) {
        _selectDepartureDate(date);
      }
    }
  }

  void selectCity(TripCity city) {
    final cityIndex = state.cities.indexOf(city);

    // If previous city dates are not selected or city already selected
    if (!(cityIndex == 0 || state.cities[cityIndex - 1].areDatesSelected) ||
        cityIndex == state.selectedCityIndex) {
      return;
    }

    emit(state.copyWith(
      selectedCityIndex: cityIndex,
      cities: state.citiesWithDeselectedDatesStartingFrom(cityIndex),
    ));
  }

  void _selectArrivalDate(DateTime? date) {
    final int selectedIndex = state.selectedCityIndex;
    final cities = List<TripCity>.from(state.cities);
    cities[selectedIndex] = cities[selectedIndex].copyWith(arrivalDate: date);

    emit(state.copyWith(cities: cities));
  }

  void _selectDepartureDate(DateTime date) {
    final int selectedIndex = state.selectedCityIndex;
    final List<TripCity> cities = List<TripCity>.from(state.cities);
    cities[selectedIndex] = cities[selectedIndex].copyWith(departureDate: date);

    if (selectedIndex != cities.length - 1) {
      final int nextIndex = selectedIndex + 1;
      cities[nextIndex] = cities[nextIndex].copyWith(arrivalDate: date);
      emit(state.copyWith(cities: cities));
      selectCity(cities[nextIndex]);
    } else {
      emit(state.copyWith(cities: cities));
    }
  }

  void _deselectArrivalDate() {
    final selectedIndex = state.selectedCityIndex;
    final cities = List<TripCity>.from(state.cities);

    if (selectedIndex == 0) {
      cities[0] = cities[selectedIndex].copyWithDeselectedDates();
      emit(state.copyWith(cities: cities));
    } else {
      selectCity(cities[selectedIndex - 1]);
    }
  }
}

extension on RangeCalendarState {
  List<TripCity> citiesWithDeselectedDatesStartingFrom(int index) =>
      cities.mapList<TripCity>((city) {
        final cityIndex = cities.indexOf(city);
        if (cityIndex == index) {
          return city.copyWithDeselectedDepartureDate();
        } else if (cityIndex > index) {
          return city.copyWithDeselectedDates();
        } else {
          return city;
        }
      });
}

part of 'range_calendar_cubit.dart';

class RangeCalendarState extends Equatable {
  const RangeCalendarState({
    required this.firstDayOfSelectedMonth,
    required this.cities,
    required this.selectedCityIndex,
  });

  final DateTime firstDayOfSelectedMonth;

  final List<TripCity> cities;

  final int selectedCityIndex;

  @override
  List<Object?> get props => [firstDayOfSelectedMonth, cities, selectedCityIndex];

  RangeCalendarState copyWith({
    DateTime? firstDayOfSelectedMonth,
    List<TripCity>? cities,
    int? selectedCityIndex,
  }) =>
      RangeCalendarState(
        firstDayOfSelectedMonth: firstDayOfSelectedMonth ?? this.firstDayOfSelectedMonth,
        cities: cities ?? this.cities,
        selectedCityIndex: selectedCityIndex ?? this.selectedCityIndex,
      );
}

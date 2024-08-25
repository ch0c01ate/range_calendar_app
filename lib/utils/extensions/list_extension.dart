import '../../data/models/trip_city.dart';
import '../../resources/text/app_titles.dart';
import 'date_time_extension.dart';

extension ListExtension<E> on List<E> {
  List<T> mapList<T>(T Function(E) toElement) => map<T>(toElement).toList();

  List<E> separatedWith(E separator) =>
      expand((E item) => [item, separator]).toList()..removeLast();

  List<T> mapSeparated<T>(T Function(E) toElement, T separator) =>
      mapList<T>(toElement).separatedWith(separator);
}

extension CityExtension on List<TripCity> {
  bool get areDatesSelected => mapList<bool>((city) => city.areDatesSelected).reduce(
        (first, second) => first && second,
      );

  String get formattedTimeInterval => areDatesSelected
      ? first.arrivalDate!.formattedIntervalTil(last.departureDate!)
      : AppTitles.datesNotSelected;
}

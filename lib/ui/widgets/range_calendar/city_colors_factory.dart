part of 'range_calendar.dart';

final class _CityColorsFactory {
  const _CityColorsFactory._();

  static List<Color> generateColors(int cityNumber) => List.generate(
        cityNumber,
        (i) => _usedColors[i % _usedColors.length],
      );

  static const List<Color> _usedColors = [
    AppColors.calendarLavenderBrown,
    AppColors.calendarLavenderBlue,
    AppColors.calendarLightBlush,
  ];
}

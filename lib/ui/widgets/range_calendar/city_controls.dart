part of 'range_calendar.dart';

class _CityControls extends StatelessWidget {
  const _CityControls();

  @override
  Widget build(BuildContext context) => BlocBuilder<RangeCalendarCubit, RangeCalendarState>(
        builder: (_, state) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.cities.mapSeparated(
              (city) {
                final colors = _CityColorsFactory.generateColors(state.cities.length);
                final index = state.cities.indexOf(city);

                return _CityButton(
                  city: city,
                  color: colors[index],
                  isSelected: index == state.selectedCityIndex,
                );
              },
              const SizedBox(width: 8),
            ),
          ),
        ),
      );
}

class _CityButton extends StatelessWidget {
  const _CityButton({
    required this.city,
    required this.color,
    required this.isSelected,
  });

  final TripCity city;

  final Color color;

  final bool isSelected;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.read<RangeCalendarCubit>().selectCity(city),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            city.name,
            style: TextStyle(
              color: isSelected ? AppColors.primaryText : color,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      );
}

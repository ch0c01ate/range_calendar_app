part of 'range_calendar.dart';

class _MonthRow extends StatelessWidget {
  const _MonthRow();

  @override
  Widget build(BuildContext context) => BlocBuilder<RangeCalendarCubit, RangeCalendarState>(
        buildWhen: (previous, current) =>
            previous.firstDayOfSelectedMonth != current.firstDayOfSelectedMonth,
        builder: (_, state) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            state.firstDayOfSelectedMonth.formattedMonth,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ),
      );
}

class _WeekdayRow extends StatelessWidget {
  const _WeekdayRow({required this.cellSize});

  final double cellSize;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _kWeekdayShortNames
            .map(
              (shortName) => SizedBox(
                width: cellSize,
                child: Center(
                  child: Text(
                    shortName.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );
}

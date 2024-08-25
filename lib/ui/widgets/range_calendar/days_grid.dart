part of 'range_calendar.dart';

class _DaysGrid extends StatelessWidget {
  const _DaysGrid({required this.cellSize});

  final double cellSize;

  @override
  Widget build(BuildContext context) => BlocBuilder<RangeCalendarCubit, RangeCalendarState>(
        builder: (_, state) {
          final DateTime firstDayOfMonth = state.firstDayOfSelectedMonth;
          final int cellsNumber =
              firstDayOfMonth.daysInMonth + firstDayOfMonth.rangeCalendarWeekday - 1;
          final int rowsNumber = (cellsNumber / _kDaysInWeek).ceil();
          final int firstWeekdayOfMonth = firstDayOfMonth.rangeCalendarWeekday;
          final double gridHeight = cellSize * _kMaximumNumberOfRowsInGrid +
              (_kMaximumNumberOfRowsInGrid - 1) * _kCellVerticalSpacing;

          return SizedBox(
            height: gridHeight,
            child: Column(
              children: List<Widget>.generate(
                rowsNumber,
                (rowIndex) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _kDaysInWeek,
                    (i) => i + rowIndex * _kDaysInWeek - firstWeekdayOfMonth + 2,
                  ).mapList(
                    (day) {
                      if (day <= 0 || day > firstDayOfMonth.daysInMonth) {
                        return _GridCell.empty(cellSize: cellSize);
                      }

                      final DateTime date = firstDayOfMonth.getDateFromDayInMonth(day);
                      final bool isInteractive = date.isAfterOrSameDateAs(DateTime.now());

                      return _GridCell(
                        cellSize: cellSize,
                        backgroundColors: state.getColorsForDate(date),
                        onPressed: isInteractive
                            ? () => context.read<RangeCalendarCubit>().selectDate(date)
                            : null,
                        child: Text(
                          '$day',
                          style: TextStyle(
                            color: isInteractive ? AppColors.primaryText : AppColors.secondaryText,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ).separatedWith(const SizedBox(height: _kCellVerticalSpacing)),
            ),
          );
        },
      );
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    required this.cellSize,
    required this.backgroundColors,
    this.onPressed,
    this.child = const SizedBox.shrink(),
  });

  const _GridCell.empty({required this.cellSize})
      : backgroundColors = const [Colors.transparent],
        onPressed = null,
        child = const SizedBox.shrink();

  final double cellSize;

  // To convert into List if could be in 3 or more cities in the same day.
  final List<Color> backgroundColors;

  final VoidCallback? onPressed;

  final Widget child;

  @override
  Widget build(BuildContext context) => ClipOval(
        child: GestureDetector(
          onTap: onPressed,
          child: backgroundColors.length > 1
              ? _DiagonallyHalvedRoundContainer(
                  size: cellSize,
                  topLeftColor: backgroundColors.first,
                  bottomRightColor: backgroundColors.last,
                  child: child,
                )
              : Container(
                  height: cellSize,
                  width: cellSize,
                  alignment: Alignment.center,
                  color: backgroundColors.first,
                  child: child,
                ),
        ),
      );
}

extension on RangeCalendarState {
  List<Color> getColorsForDate(DateTime date) {
    final List<Color> cityColors = _CityColorsFactory.generateColors(cities.length);
    final List<Color> resultColors = [];

    for (var i = 0; i < cities.length; i++) {
      final arrivalDate = cities[i].arrivalDate;
      final departureDate = cities[i].departureDate;

      bool addColor = false;

      if (arrivalDate?.isSameDateAs(date) ?? false) {
        addColor = true;
      }

      if (arrivalDate != null &&
          departureDate != null &&
          date.isInDateInterval(arrivalDate, departureDate)) {
        addColor = true;
      }

      if (addColor) {
        resultColors.add(cityColors[i]);
      }
    }

    return resultColors.isEmpty ? [Colors.transparent] : resultColors;
  }
}

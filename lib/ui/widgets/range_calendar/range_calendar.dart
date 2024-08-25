import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/range_calendar/range_calendar_cubit.dart';
import '../../../data/models/trip_city.dart';
import '../../../resources/text/app_titles.dart';
import '../../../resources/theme/app_colors.dart';
import '../../../resources/theme/app_shadows.dart';
import '../../../utils/extensions/date_time_extension.dart';
import '../../../utils/extensions/list_extension.dart';

part 'city_colors_factory.dart';
part 'city_controls.dart';
part 'constants.dart';
part 'days_grid.dart';
part 'diagonally_halved_round_container.dart';
part 'month_controls.dart';
part 'month_and_weekday_row.dart';

class RangeCalendar extends StatelessWidget {
  const RangeCalendar({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CityControls(),
          const SizedBox(height: 24),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppShadows.primary,
              ),
              child: LayoutBuilder(
                builder: (_, constraints) {
                  final cellSize =
                      (constraints.maxWidth - (_kDaysInWeek - 1) * _kCellHorizontalSpacing) /
                          _kDaysInWeek; // (Maximum width - spacing) / number of cells

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _WeekdayRow(cellSize: cellSize),
                      const SizedBox(height: 8),
                      const _MonthRow(),
                      const SizedBox(height: 6),
                      _DaysGrid(cellSize: cellSize),
                      const SizedBox(height: 24),
                      _MonthControls(buttonSize: cellSize),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/range_calendar/range_calendar_cubit.dart';
import '../../data/models/trip_city.dart';
import '../../resources/text/app_titles.dart';
import '../../resources/theme/app_colors.dart';
import '../../utils/extensions/list_extension.dart';
import '../widgets/range_calendar/range_calendar.dart';

class CalendarBottomSheet extends StatelessWidget {
  const CalendarBottomSheet({super.key});

  static Future<List<TripCity>?> show(BuildContext context, List<TripCity> cities) =>
      showModalBottomSheet<List<TripCity>>(
        context: context,
        isScrollControlled: true,
        builder: (_) => BlocProvider(
          create: (_) => RangeCalendarCubit(initialCities: cities),
          child: const CalendarBottomSheet(),
        ),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.quarternaryBackground,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.only(top: 32),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.tertiaryBackground,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Column(
                children: [
                  Text(
                    AppTitles.selectTripDates,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Flexible(child: RangeCalendar()),
                  // SizedBox(height: 16),
                  _DoneButton(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _DoneButton extends StatelessWidget {
  const _DoneButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<RangeCalendarCubit, RangeCalendarState>(
        buildWhen: (previous, current) => previous.cities != current.cities,
        builder: (_, state) {
          final bool isActive = state.cities.areDatesSelected;
          return GestureDetector(
            onTap: isActive
                ? () {
                    Navigator.of(context).pop(state.cities);
                  }
                : null,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryButton : AppColors.inactiveButton,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppTitles.done.toUpperCase(),
                    style: TextStyle(
                      color: isActive ? AppColors.primaryText : AppColors.invertedText,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? AppColors.secondaryButton : AppColors.inactiveButton,
                    ),
                    child: Icon(
                      Icons.arrow_forward_sharp,
                      color: isActive ? AppColors.primaryText : AppColors.invertedText,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
}

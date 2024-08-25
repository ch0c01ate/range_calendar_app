import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/trip/trip_cubit.dart';
import '../../data/models/trip_city.dart';
import '../../resources/text/app_titles.dart';
import '../../resources/theme/app_colors.dart';
import '../../resources/theme/app_shadows.dart';
import '../../utils/extensions/list_extension.dart';
import '../bottom_sheets/calendar_bottom_sheet.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppShadows.primary,
                ),
                child: BlocBuilder<TripCubit, TripState>(
                  builder: (_, state) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final newCities = await CalendarBottomSheet.show(
                                  context,
                                  state.trip.cities,
                                );
                                if (newCities != null) {
                                  // ignore: use_build_context_synchronously
                                  context.read<TripCubit>().switchCities(newCities);
                                }
                              },
                              child: Text(
                                state.trip.cities.formattedTimeInterval,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.secondaryText,
                                ),
                              ),
                            ),
                            Text(
                              '${state.trip.people.length} ${AppTitles.people}',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...state.trip.cities.mapSeparated(
                          (city) => _CityInfo(city: city),
                          Container(
                            height: 0.5,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primaryText.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _CityInfo extends StatelessWidget {
  const _CityInfo({required this.city});

  final TripCity city;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              city.name,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ...city.infoItems.mapSeparated(
              (item) => _CityInfoRow(title: item.title, value: item.value),
              const SizedBox(height: 16),
            ),
          ],
        ),
      );
}

class _CityInfoRow extends StatelessWidget {
  const _CityInfoRow({
    required this.title,
    this.value,
  });

  final String title;

  final String? value;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
          ),
          if (value != null) ...[
            const SizedBox(width: 8),
            SizedBox(
              width: 150,
              child: Text(
                value!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
            ),
          ],
          const SizedBox(width: 8),
          Icon(
            value == null ? Icons.add : Icons.edit,
            size: 16,
            color: AppColors.secondaryText,
          ),
        ],
      );
}

class _CityInfoItem {
  _CityInfoItem({required this.title, required this.value});

  final String title;
  final String? value;
}

extension on TripCity {
  List<_CityInfoItem> get infoItems => [
        _CityInfoItem(
          title: AppTitles.accommodations,
          value: accommodations.mapList((a) => a.title).value,
        ),
        _CityInfoItem(
          title: AppTitles.flights,
          value: flights.mapList((a) => a.title).value,
        ),
        _CityInfoItem(
          title: AppTitles.activities,
          value: activities.mapList((a) => a.title).value,
        ),
        _CityInfoItem(
          title: AppTitles.rents,
          value: rents.mapList((a) => a.title).value,
        ),
      ];
}

extension on List<String> {
  String? get value => isEmpty ? null : join(', ');
}

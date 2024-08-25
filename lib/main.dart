import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/trip/trip_cubit.dart';
import 'ui/pages/trip_page.dart';

void main() {
  runApp(const RangeCalendarApp());
}

class RangeCalendarApp extends StatelessWidget {
  const RangeCalendarApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Range Calendar App',
        debugShowCheckedModeBanner: false,
        home: BlocProvider<TripCubit>(
          create: (context) => TripCubit(),
          child: const TripPage(),
        ),
      );
}

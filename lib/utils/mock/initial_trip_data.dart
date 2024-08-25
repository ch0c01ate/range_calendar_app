import '../../data/models/accommodation.dart';
import '../../data/models/activity.dart';
import '../../data/models/person.dart';
import '../../data/models/trip.dart';
import '../../data/models/trip_city.dart';

Trip getInitialTripData() => Trip(
      cities: [
        TripCity(
          name: 'Prague',
          accommodations: const [
            Accommodation(title: 'Standard Double Room'),
            Accommodation(title: 'Standard Double Room'),
          ],
          arrivalDate: DateTime(2024, 9),
          departureDate: DateTime(2024, 9, 6),
        ),
        TripCity(
          name: 'Paris',
          activities: const [Activity(title: 'Private tour of Centre Pompidou')],
          arrivalDate: DateTime(2024, 9, 6),
          departureDate: DateTime(2024, 9, 10),
        ),
        TripCity(
          name: 'London',
          arrivalDate: DateTime(2024, 9, 10),
          departureDate: DateTime(2024, 9, 15),
        ),
      ],
      people: const [
        Person(name: 'Michael Jordan'),
        Person(name: 'LeBron James'),
      ],
    );

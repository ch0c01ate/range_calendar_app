import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  const Activity({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

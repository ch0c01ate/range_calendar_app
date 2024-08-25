import 'package:equatable/equatable.dart';

class Flight extends Equatable {
  const Flight({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

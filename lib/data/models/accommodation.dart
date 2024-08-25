import 'package:equatable/equatable.dart';

class Accommodation extends Equatable {
  const Accommodation({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

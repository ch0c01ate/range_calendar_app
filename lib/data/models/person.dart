import 'package:equatable/equatable.dart';

class Person extends Equatable {
  const Person({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

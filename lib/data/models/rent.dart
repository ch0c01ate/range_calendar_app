import 'package:equatable/equatable.dart';

class Rent extends Equatable {
  const Rent({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

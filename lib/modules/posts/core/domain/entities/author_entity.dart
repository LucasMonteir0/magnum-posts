import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  final int id;
  final String name;

  const AuthorEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

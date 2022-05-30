import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String nim;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.nim,
  });

  get nameGet {
    return name;
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        nim,
      ];
}

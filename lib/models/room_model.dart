import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final bool status;
  final String date;

  RoomModel({
    required this.id,
    this.title = '',
    this.location = '',
    this.imageUrl = '',
    this.status = false,
    this.date = '',
  });

  factory RoomModel.fromJson(String id, Map<String, dynamic> json) => RoomModel(
        id: id,
        title: json['title'],
        location: json['location'],
        imageUrl: json['imageUrl'],
        status: json['status'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'imageUrl': imageUrl,
        'status': status,
        'date': date,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        imageUrl,
        status,
        date,
      ];
}

import 'package:booking_app/models/room_model.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final RoomModel room;
  final String id;

  const OrderModel({
    required this.room,
    this.id = '',
  });

  factory OrderModel.fromJson(String id, Map<String, dynamic> json) {
    return OrderModel(
      id: id,
      room: RoomModel.fromJson(json['room']['id'], json['room']),
    );
  }

  @override
  List<Object?> get props => [
        room,
      ];
}

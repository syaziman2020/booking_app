part of 'room_cubit.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomSuccess extends RoomState {
  final List<RoomModel> rooms;

  RoomSuccess(this.rooms);

  @override
  List<Object> get props => [rooms];
}

class RoomFailed extends RoomState {
  final String error;

  RoomFailed(this.error);

  @override
  List<Object> get props => [error];
}

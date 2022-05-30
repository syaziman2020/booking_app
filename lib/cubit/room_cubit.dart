import 'package:bloc/bloc.dart';
import 'package:booking_app/models/room_model.dart';
import 'package:booking_app/services/room_services.dart';
import 'package:equatable/equatable.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());
  void fetchRoom() async {
    try {
      emit(RoomLoading());
      List<RoomModel> rooms = await RoomServices().fetchRooms();
      emit(RoomSuccess(rooms));
    } catch (e) {
      emit(RoomFailed(e.toString()));
    }
  }

  void updateStatus(String id, bool status) async {
    try {
      emit(RoomLoading());
      RoomServices().updateStatus(id, status);
    } catch (e) {
      emit(RoomFailed(e.toString()));
    }
  }

  void updateDate(String id, String date) async {
    try {
      emit(RoomLoading());
      RoomServices().updateDate(id, date);
    } catch (e) {
      emit(RoomFailed(e.toString()));
    }
  }
}

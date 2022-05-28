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
}

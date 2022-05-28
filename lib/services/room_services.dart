import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/room_model.dart';

class RoomServices {
  CollectionReference _roomReference =
      FirebaseFirestore.instance.collection('rooms');

  Future<List<RoomModel>> fetchRooms() async {
    try {
      QuerySnapshot result = await _roomReference.get();

      List<RoomModel> rooms = result.docs.map(
        (e) {
          return RoomModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();
      return rooms;
    } catch (e) {
      throw e;
    }
  }
}

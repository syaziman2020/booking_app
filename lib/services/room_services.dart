import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/room_model.dart';

class RoomServices {
  final CollectionReference _roomReference =
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

  void updateStatus(String id, bool status) async {
    try {
      var updateStatus = _roomReference.doc(id).update({'status': status});
    } catch (e) {
      throw e;
    }
  }

  void updateDate(String id, String date) async {
    try {
      var updateDate = _roomReference.doc(id).update({'date': date});
    } catch (e) {
      throw e;
    }
  }
}

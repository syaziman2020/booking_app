import 'package:booking_app/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final CollectionReference _orderReference =
      FirebaseFirestore.instance.collection('orders');

  Future<void> createOrder(OrderModel? order) async {
    try {
      _orderReference.add({
        'room': order?.room.toJson(),
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<OrderModel>> fetchOrders() async {
    try {
      QuerySnapshot result = await _orderReference.get();

      List<OrderModel> orders = result.docs.map(
        (e) {
          return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      return orders;
    } catch (e) {
      throw e;
    }
  }

  // void updateDate(String id, String date) async {
  //   try {
  //     var updateDate = _orderReference.doc(id).update({'room.date': date});
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}

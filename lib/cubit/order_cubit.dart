import 'package:bloc/bloc.dart';
import 'package:booking_app/models/order_model.dart';
import 'package:equatable/equatable.dart';

import '../services/order_services.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void createOrder(OrderModel? order) async {
    try {
      emit(OrderLoading());
      await OrderService().createOrder(order);
      emit(OrderSuccess([]));
    } catch (e) {
      emit(OrderFailed(e.toString()));
    }
  }

  void fetchOrders() async {
    try {
      emit(OrderLoading());

      List<OrderModel> orders = await OrderService().fetchOrders();
      emit(OrderSuccess(orders));
    } catch (e) {
      emit(OrderFailed(e.toString()));
    }
  }

  // void updateDate(String id, String date) async {
  //   try {
  //     emit(OrderLoading());
  //     OrderService().updateDate(id, date);
  //   } catch (e) {
  //     emit(OrderFailed(e.toString()));
  //   }
  // }
}

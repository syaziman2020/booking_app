part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];

  get orders => null;
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> orders;
  OrderSuccess(this.orders);
  @override
  List<Object> get props => [orders];
}

class OrderFailed extends OrderState {
  final String error;
  OrderFailed(this.error);

  @override
  List<Object> get props => [error];
}

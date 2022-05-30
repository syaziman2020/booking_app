import 'package:booking_app/cubit/order_cubit.dart';
import 'package:booking_app/cubit/room_cubit.dart';
import 'package:booking_app/models/order_model.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderModel? orderModel;
  @override
  void initState() {
    context.read<OrderCubit>().fetchOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrderSuccess) {
            if (state.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty.png',
                      width: size.width * 0.7,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Order is Empty',
                      style: blueTextStyle.copyWith(
                          fontSize: 20, fontWeight: medium),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    onTap: () {
                      showDialogAlert(
                        context: context,
                        title: 'Message',
                        message: 'Do you want to delete your order?',
                        actionButtonTitle: 'Yes',
                        cancelButtonTitle: 'No',
                      );
                    },
                    orderModel: state.orders[index],
                  );
                },
                padding: const EdgeInsets.only(top: 30),
              );
            }
          }
          return Center(
              child: Text(
            'order',
            style: blackTextStyle,
          ));
        },
      ),
    );
  }
}

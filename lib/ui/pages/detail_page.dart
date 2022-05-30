import 'package:booking_app/cubit/current_page_cubit.dart';
import 'package:booking_app/cubit/order_cubit.dart';
import 'package:booking_app/cubit/room_cubit.dart';
import 'package:booking_app/models/order_model.dart';
import 'package:booking_app/models/room_model.dart';
import 'package:booking_app/ui/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final RoomModel roomModel;
  OrderModel? orderModel;

  DetailPage({
    Key? key,
    required this.roomModel,
    this.orderModel,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget pictContent() {
      return Container(
        padding: const EdgeInsets.only(top: 40, left: 24),
        margin: const EdgeInsets.only(bottom: 32),
        alignment: Alignment.topLeft,
        width: double.infinity,
        height: size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.roomModel.imageUrl),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: blueC,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/arrow_back.svg',
                fit: BoxFit.cover,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomModel.title,
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                (widget.roomModel.status)
                    ? SvgPicture.asset(
                        'assets/icons/checked.svg',
                        fit: BoxFit.cover,
                        width: 20,
                        height: 20,
                      )
                    : SvgPicture.asset(
                        'assets/icons/unchecked.svg',
                        fit: BoxFit.cover,
                        width: 20,
                        height: 20,
                      ),
                const SizedBox(
                  width: 5,
                ),
                (widget.roomModel.status)
                    ? Text(
                        'Already booked until:',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      )
                    : Text(
                        'You can booked now:',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2099),
                ).then((date) {
                  //tambahkan setState dan panggil variabel _dateTime.
                  setState(() {
                    _dateTime = date;
                    context.read<RoomCubit>().updateDate(
                          widget.roomModel.id,
                          DateFormat('dd-MM-yyyy').format(date!).toString(),
                        );
                  });
                });
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/note.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  (widget.roomModel.status)
                      ? Text(
                          widget.roomModel.date,
                          style: blackTextStyle.copyWith(
                            color: blackC,
                          ),
                        )
                      : Text(
                          (_dateTime == null)
                              ? '-'
                              : DateFormat('dd-MM-yyyy').format(_dateTime!),
                          style: blackTextStyle.copyWith(
                            color: blackC,
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/pin2.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.roomModel.location,
                  style: blackTextStyle.copyWith(
                    color: blackC,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'About Room',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              widget.roomModel.desc,
              style: blackTextStyle.copyWith(
                color: blackC.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state is OrderSuccess) {
                    context.read<CurrentPageCubit>().currentPage(1);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  } else if (state is OrderFailed) {
                    showDialogAlert(
                      context: context,
                      title: 'Failed',
                      message: state.error,
                      actionButtonTitle: 'OK',
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    title: 'Booked Now',
                    onTap: () {
                      if (widget.roomModel.status) {
                        showDialogAlert(
                          context: context,
                          title: 'Sorry',
                          message: 'This room already booked',
                          actionButtonTitle: 'OK',
                        );
                      } else {
                        context.read<OrderCubit>().createOrder(OrderModel(
                              room: widget.roomModel,
                            ));
                        setState(() {
                          FirebaseFirestore.instance
                              .collection('rooms')
                              .doc(widget.roomModel.id)
                              .update({
                            'room': {
                              'date':
                                  (DateFormat('dd-MM-yyyy').format(_dateTime!))
                            }
                          });
                        });
                        context.read<RoomCubit>().updateStatus(
                            widget.roomModel.id, !widget.roomModel.status);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgC,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          pictContent(),
          content(),
        ],
      ),
    );
  }
}

import 'package:booking_app/models/room_model.dart';
import 'package:booking_app/ui/widgets/custom_button.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class DetailPage extends StatefulWidget {
  final RoomModel roomModel;
  const DetailPage({Key? key, required this.roomModel}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController _controller3;
  String _valueToValidate3 = '';
  String _valueSaved3 = '';

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        _controller3.text = '2002-11-22';
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'pt_BR';
    //_initialValue = DateTime.now().toString();

    _controller3 = TextEditingController(text: DateTime.now().toString());

    _getValue();
  }

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
          borderRadius: BorderRadius.only(
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
                SizedBox(
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
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/note.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                SizedBox(
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
                        '-',
                        style: blackTextStyle.copyWith(
                          color: blackC,
                        ),
                      ),
              ],
            ),
            SizedBox(
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
                SizedBox(
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
            SizedBox(height: 18),
            Text(
              'About Room',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 9,
            ),
            Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, ',
              style: blackTextStyle.copyWith(
                color: blackC.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                title: 'Booked Now',
                onTap: () {
                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }

                      return true;
                    },
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgC,
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            pictContent(),
            content(),
          ],
        ),
      ),
    );
  }
}

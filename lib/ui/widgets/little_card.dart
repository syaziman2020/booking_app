import 'package:booking_app/models/room_model.dart';
import 'package:booking_app/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/theme.dart';

class LittleCard extends StatelessWidget {
  final RoomModel roomModel;

  const LittleCard({
    Key? key,
    required this.roomModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(roomModel: roomModel),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteC,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          roomModel.imageUrl,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomModel.title,
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        roomModel.location,
                        style: greyTextStyleC.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              (roomModel.status)
                  ? SvgPicture.asset(
                      'assets/icons/checked.svg',
                      width: 20,
                      height: 20,
                    )
                  : SvgPicture.asset(
                      'assets/icons/unchecked.svg',
                      width: 20,
                      height: 20,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

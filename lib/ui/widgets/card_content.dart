import 'package:booking_app/models/room_model.dart';
import 'package:booking_app/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/theme.dart';

class CardContent extends StatelessWidget {
  final RoomModel roomModel;
  const CardContent({
    Key? key,
    required this.roomModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(roomModel: roomModel)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 24, top: 12),
        padding: const EdgeInsets.only(
          top: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 256,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(roomModel.imageUrl),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    roomModel.title,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/location1.svg',
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        roomModel.location,
                        style: greyTextStyleC,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 280,
              height: 0.5,
              decoration: const BoxDecoration(
                color: greyC,
              ),
            ),
            Container(
              width: 280,
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: greyTextStyleC,
                  ),
                  Row(
                    children: [
                      (roomModel.status)
                          ? Text(
                              'Already Booked',
                              style: greyTextStyleC,
                            )
                          : Text(
                              'Not Booked',
                              style: greyTextStyleC,
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      (roomModel.status)
                          ? SvgPicture.asset(
                              'assets/icons/checked.svg',
                              width: 15,
                              height: 15,
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              'assets/icons/unchecked.svg',
                              width: 15,
                              height: 15,
                              fit: BoxFit.cover,
                            )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

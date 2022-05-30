import 'package:booking_app/cubit/current_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/theme.dart';

class NavigationItem extends StatelessWidget {
  final String svgUrl;
  final String title;
  final int index;
  final Function() onTap;
  const NavigationItem({
    Key? key,
    required this.title,
    required this.svgUrl,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPageCubit, int>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgUrl,
                width: 22,
                height: 22,
                color: (index == state) ? blueC : greyD,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                title,
                style: blueTextStyle.copyWith(
                  fontWeight: medium,
                  color: (index == state) ? blueC : greyD,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

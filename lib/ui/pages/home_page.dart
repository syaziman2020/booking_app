import 'package:booking_app/cubit/auth_cubit.dart';
import 'package:booking_app/cubit/current_page_cubit.dart';
import 'package:booking_app/cubit/room_cubit.dart';
import 'package:booking_app/shared/theme.dart';
import 'package:booking_app/ui/pages/order_page.dart';
import 'package:booking_app/ui/pages/profile_page.dart';
import 'package:booking_app/ui/pages/search_page.dart';
import 'package:booking_app/ui/widgets/card_content.dart';
import 'package:booking_app/ui/widgets/little_card.dart';
import 'package:booking_app/ui/widgets/navigation_item.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/room_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<RoomCubit>().fetchRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget profileInfo() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            margin: EdgeInsets.only(
              top: size.height * 0.05,
              bottom: 24,
              right: 24,
              left: 24,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteC,
              borderRadius: BorderRadius.circular(12),
            ),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.name,
                        style: greyTextStyleC,
                      ),
                      Text(
                        state.user.nim,
                        style: blueTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  );
                } else
                  return SizedBox();
              },
            ),
          ),
        ],
      );
    }

    Widget navBar() {
      return Container(
        width: size.width,
        height: 70,
        decoration: BoxDecoration(
          color: whiteC,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavigationItem(
                title: 'Home',
                svgUrl: 'assets/icons/home.svg',
                index: 0,
                onTap: () {
                  context.read<CurrentPageCubit>().currentPage(0);
                },
              ),
              NavigationItem(
                title: 'Search',
                svgUrl: 'assets/icons/search.svg',
                index: 1,
                onTap: () {
                  context.read<CurrentPageCubit>().currentPage(1);
                },
              ),
              NavigationItem(
                title: 'Order',
                svgUrl: 'assets/icons/order3.svg',
                index: 2,
                onTap: () {
                  context.read<CurrentPageCubit>().currentPage(2);
                },
              ),
              NavigationItem(
                title: 'Profile',
                svgUrl: 'assets/icons/profile.svg',
                index: 3,
                onTap: () {
                  context.read<CurrentPageCubit>().currentPage(3);
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget cardPopular(List<RoomModel> room) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: room
                .map((RoomModel room) => CardContent(roomModel: room))
                .toList()),
      );
    }

    Widget allRoom(List<RoomModel> room) {
      return Column(
          children: room
              .map((RoomModel room) => LittleCard(roomModel: room))
              .toList());
    }

    Widget homeContent() {
      return BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) {
          if (state is RoomFailed) {
            showDialogAlert(
              context: context,
              title: 'Failed',
              message: state.error,
              actionButtonTitle: 'OK',
            );
          }
        },
        builder: (context, state) {
          if (state is RoomSuccess) {
            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height * 0.11,
                      decoration: const BoxDecoration(color: blueC),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profileInfo(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Popular',
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        cardPopular(state.rooms),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'All room',
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        allRoom(state.rooms),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    Widget buildContent(int index) {
      switch (index) {
        case 0:
          return homeContent();
        case 1:
          return SearchPage();
        case 2:
          return OrderPage();
        case 3:
          return ProfilePage();

        default:
          return HomePage();
      }
    }

    return Scaffold(
        backgroundColor: bgC,
        bottomNavigationBar: navBar(),
        body: BlocBuilder<CurrentPageCubit, int>(
          builder: (context, state) {
            return buildContent(state);
          },
        ));
  }
}

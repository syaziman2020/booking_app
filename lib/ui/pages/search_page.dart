import 'package:booking_app/shared/theme.dart';
import 'package:booking_app/ui/widgets/little_card.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget headerContent() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find the perfect room',
              style: greyTextStyleC.copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              'Faculty of Math and Science',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      );
    }

    Widget searchBox() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: TextField(
          cursorColor: blueC,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: greyTextStyleC,
            focusColor: whiteC,
            fillColor: whiteC,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Color(0xffF1F1F1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
                color: Color(0xffF1F1F1),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            prefixIcon: const Icon(
              Icons.search,
              color: greyC,
            ),
          ),
        ),
      );
    }

    Widget lineBarrier() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 24),
        width: double.infinity,
        height: 1,
        decoration: const BoxDecoration(
          color: Color(0xffeeeeee),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgC,
      body: ListView(
        padding: EdgeInsets.only(top: 40),
        children: [
          headerContent(),
          searchBox(),
          lineBarrier(),
        ],
      ),
    );
  }
}

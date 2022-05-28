import 'package:booking_app/shared/theme.dart';
import 'package:booking_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgC,
      body: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [whiteC, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(
                Rect.fromLTRB(0, 0, bounds.width, bounds.height),
              );
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/untan.png'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Booking room\nfor your events',
            textAlign: TextAlign.center,
            style: blueTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 36,
            ),
          ),
          SizedBox(
            height: size.height * 0.09,
          ),
          CustomButton(
            title: 'Get Started',
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            width: 219,
          ),
          const SizedBox(
            height: 19,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              'Have an account?',
              style: blackTextStyle.copyWith(
                fontSize: 12,
                color: blackC.withOpacity(0.7),
              ),
            ),
          )
        ],
      ),
    );
  }
}

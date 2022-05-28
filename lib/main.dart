import 'package:booking_app/cubit/auth_cubit.dart';
import 'package:booking_app/cubit/current_page_cubit.dart';
import 'package:booking_app/cubit/room_cubit.dart';
import 'package:booking_app/models/room_model.dart';
import 'package:booking_app/ui/pages/detail_page.dart';
import 'package:booking_app/ui/pages/home_page.dart';
import 'package:booking_app/ui/pages/introduction_page.dart';
import 'package:booking_app/ui/pages/login_page.dart';
import 'package:booking_app/ui/pages/register_page.dart';
import 'package:booking_app/ui/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentPageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => RoomCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/introduction': (context) => const IntroductionPage(),
          '/home': (context) => const HomePage(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
        },
        supportedLocales: [Locale('en', 'US')],
      ),
    );
  }
}

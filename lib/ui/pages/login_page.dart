import 'package:booking_app/cubit/auth_cubit.dart';
import 'package:booking_app/ui/widgets/custom_button.dart';
import 'package:booking_app/ui/widgets/custom_textfield.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passController = TextEditingController(text: '');
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget header() {
      return Column(
        children: [
          Text(
            'Login',
            style: blueTextStyle.copyWith(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Booking room for your personal events',
            style: blackTextStyle.copyWith(
              fontSize: 14,
              color: blackC.withOpacity(0.7),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgC,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/untan.png',
            width: double.infinity,
            height: size.height * 0.4,
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 30, 24, 0),
                margin: EdgeInsets.only(top: size.height * 0.35),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: bgC,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    header(),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomField(
                      labelText: 'Email',
                      controller: emailController,
                    ),
                    CustomField(
                      labelText: 'Password',
                      hideText: true,
                      controller: passController,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Don\'t Have an account? Create an account',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            color: blackC.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', ((route) => false));
                        } else if (state is AuthFailed) {
                          showDialogAlert(
                            context: context,
                            title: 'Failed',
                            message: state.error,
                            actionButtonTitle: 'OK',
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomButton(
                          title: 'Login',
                          onTap: () {
                            context.read<AuthCubit>().logIn(
                                  email: emailController.text,
                                  password: passController.text,
                                );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

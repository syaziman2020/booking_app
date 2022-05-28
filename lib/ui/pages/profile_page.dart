import 'package:booking_app/cubit/auth_cubit.dart';
import 'package:booking_app/cubit/current_page_cubit.dart';
import 'package:booking_app/shared/theme.dart';
import 'package:booking_app/ui/widgets/custom_button.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
              top: size.height * 0.3,
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
                        'Name : ${state.user.name}',
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'NIM : ${state.user.nim}',
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Email : ${state.user.email}',
                        style: blackTextStyle.copyWith(fontSize: 16),
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

    return Scaffold(
      backgroundColor: bgC,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          profileInfo(),
          SizedBox(
            height: 40,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthFailed) {
                showDialogAlert(
                  context: context,
                  title: 'Failed',
                  message: state.error,
                  actionButtonTitle: 'OK',
                );
              } else if (state is AuthInitial) {
                context.read<CurrentPageCubit>().currentPage(0);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomButton(
                title: 'Log Out',
                onTap: () {
                  context.read<AuthCubit>().logOut();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

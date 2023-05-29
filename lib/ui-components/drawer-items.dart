// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user/user.bloc.dart';
import '../bloc/user/user.event.dart';
import '../bloc/user/user.state.dart';
import '../data/auth.data.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget? widget;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.widget,
  });
}

class DrawerItems {
  static final AuthData authData = AuthData();
 static final userId = authData.getCurrentUserId();
  static final UserBloc userBloc = UserBloc();
  static final profile = DrawerItem(

    widget: SizedBox(
      height: 120,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              backgroundImage: AssetImage('assets/Images/default_profile_picture.png'),
            ),
            const SizedBox(height: 8),
            BlocProvider(
              create: (_) => userBloc..add(GetUserCredential(userId!)),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CredentialSuccessState) {
                    return Text(
                      '${state.model.userName?.replaceAll("_", " ").toUpperCase()}',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800,color: Colors.white)),
                    );
                  }
                  if (state is CredentialLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is CredentialFailedState) {
                    return const Text('Failed to login please try again');
                  }
                  if (state is CredentialErrorState) {
                    return const Text(
                        'Error while getting user credential');
                  }
                  return const Text('State not found');
                },
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 3,
            ),
          ],
        ),
      ),
    ), title: 'profile', icon: Icons.account_circle,
  );

  static final home = DrawerItem(
    title: 'Home',
    icon: Icons.home,
    widget: null
  );

  static final settings = DrawerItem(
    title: 'Settings',
    icon: Icons.settings,
    widget:null
  );

  static final logout = DrawerItem(
    title: 'Log Out',
    icon: Icons.logout,
    widget: null
  );

  static final helpAndFaq = DrawerItem(
    title: 'Help & FAQ',
    icon: Icons.help,
    widget: null
  );

  static final pp = DrawerItem(
    title: 'Privacy Policies',
    icon: Icons.privacy_tip_sharp,
    widget: null,
  );

  static final notifications = DrawerItem(
    title: 'Notifications',
    icon: Icons.notifications,
    widget: null
  );

  static final contactUs = DrawerItem(
    title: 'Contact Us',
    icon: Icons.call,
    widget: null
  );



  static final termsOfService = DrawerItem(
    title: 'Terms of Service',
    icon: Icons.article,
    widget: null
  );



  static final all = [
    profile,
    home,
    notifications,
    settings,
    pp,
    termsOfService,
    contactUs,
    logout
  ];
}

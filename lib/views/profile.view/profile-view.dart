import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/auth/auth.block.dart';
import 'package:voyage/bloc/auth/auth.event.dart';
import 'package:voyage/bloc/auth/auth.state.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/ui-components/profile-components/city-cards.dart';
import 'package:voyage/ui-components/profile-components/dashboard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthBloc _authBloc = new AuthBloc();
  final AuthData _authData = new AuthData();

  @override
  void initState() {
    super.initState();
    var userId = _authData.getCurrentUserId();
    _authBloc.add(GetUserCredential(userId!));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
           Column(
             children: [
               Container(
                 height: 400,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.withOpacity(0.5),
                       spreadRadius: 3,
                       blurRadius: 5,
                       offset: const Offset(0, 2),
                     ),
                   ],
                   image:  const DecorationImage(
                     image: AssetImage('assets/Images/3.jpeg'),
                     fit: BoxFit.cover,

                   ) ,
                 )
               ),
               const SizedBox(height: 10),
               BlocProvider(
                create: (_) => _authBloc,
                 child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is CredentialSuccessState) {
                      return  Text(
                     '${state.model.userName}',
                     style: GoogleFonts.pacifico(
                         textStyle:  const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)
                     ),
                      );
                    }
                    if (state is CredentialLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    if (state is CredentialFailedState) {
                      return const Text('Failed to login please try again');
                    }
                    if (state is CredentialErrorState) {
                      return const Text('Error while getting user credential');
                    }
                    return const Text('State not found');
                  },
                 ),
               ),
             ],
           ),

            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Interested Cities',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  CityCards(),
                ],
              ),
            ),
            const Divider(
              color: 	Color.fromRGBO(211, 211, 211,100),
              thickness: 3,
            ),
            const Dashboard(),

          ],
        ),
      ),
    );
  }
}
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyage/bloc/schedule/schedule.bloc.dart';
import 'package:voyage/bloc/schedule/schedule.event.dart';
import 'package:voyage/bloc/schedule/schedule.state.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule-card.dart';

class SchedulesScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final AuthData _authData = AuthData();
  final ScheduleBloc _scheduleBloc = ScheduleBloc();
  @override
  void initState() {
    super.initState();

    var userId = _authData.getCurrentUserId();
    if (userId != null) {
      _scheduleBloc.add(GetUserSchedule(userId: userId));
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (context) => _scheduleBloc,
        child: BlocConsumer<ScheduleBloc, ScheduleState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            if (state is GetScheduleLoadedState) {
              return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio:
                    1.0, // Adjust this value to change the aspect ratio
              ),
              itemCount: state.schedule.length,
              itemBuilder: (BuildContext context, int index) {
                final random = Random();
                return AnimatedOpacity(
                  duration: Duration(milliseconds: random.nextInt(800) + 400),
                  opacity: _controller.value,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: random.nextInt(800) + 400),
                    curve: Curves.easeInOut,
                    child: IntrinsicHeight(
                      child: ScheduleCard(state.schedule[index],
                          maxHeight: 300), // Add maxHeight to the ScheduleCard
                    ),
                  ),
                );
              },
            );
            }
            if (state is GetScheduleErrorState) {
              return  Text('Error ${state.errorMessage}');
            }
            if (state is GetScheduleInitialState) {
              return const Text('InitialState');
            }
            if (state is GetScheduleLoadingState) {
              return const CircularProgressIndicator();
            }
            return const Text('Unknown state');
          },
        ),
      ),
    );
  }
}



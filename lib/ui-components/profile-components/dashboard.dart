// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/bloc/interested-category/interested-category.bloc.dart';
import 'package:voyage/bloc/interested-category/interested-category.event.dart';
import 'package:voyage/bloc/interested-category/interested-category.state.dart';
import 'package:voyage/data/auth.data.dart';
import 'package:voyage/models/interested-category.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Text('Your Statistics',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ))),
          ),
          const CategoryStatistics(),
        ],
      ),
    );
  }
}

class CategoryStatistics extends StatefulWidget {
  const CategoryStatistics({super.key});

  @override
  _CategoryStatisticsState createState() => _CategoryStatisticsState();
}

class _CategoryStatisticsState extends State<CategoryStatistics>
    with SingleTickerProviderStateMixin {

  final InterestedCategoryBloc _interestedCategoryBloc =
      InterestedCategoryBloc();
  final AuthData _authData = AuthData();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    var userId = _authData.getCurrentUserId();
    _interestedCategoryBloc.add(FetchInterestedCategories(userId!));
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _interestedCategoryBloc,
      child: BlocConsumer<InterestedCategoryBloc, InterestedCategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InterestedCategorySuccessState) {
            return SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                maxY: 1.1,
                minY: 0,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${state.categories[group.x.toInt()].placeCategoryStringValue}\n${(rod.y * 100).toStringAsFixed(0)}%',
                        GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(44, 87, 116, 100),
                                fontSize: 12,
                                fontWeight: FontWeight.w900)),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: false,
                  ),
                  leftTitles: SideTitles(showTitles: false),
                ),
                borderData: FlBorderData(show: false),
                barGroups: state.categories.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final InterestedCategory category = entry.value;
                  final double cappedPercentage = min(1.0, (category.count! * 0.1));
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        y: cappedPercentage * _animation.value,
                        colors: [
                          const Color.fromRGBO(44, 87, 116, 100),
                          Colors.grey
                        ],
                        borderRadius: BorderRadius.circular(5),
                        width: 16,
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  );
                }).toList(),
              ),
            ),
          );
          }

          if (state is InterestedCategoryErrorState) {
            return const Text('Error on fetching categories');
          }
          if (state is InterestedCategoryLoadingState) {
            return const CircularProgressIndicator();
          }
          return const Text('State is not found');
          
        },
      ),
    );
  }
}

class CategoryData {
  final String name;
  final IconData icon;
  final double value;

  CategoryData(this.name, this.icon, this.value);
}

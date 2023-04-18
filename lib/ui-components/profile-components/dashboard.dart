import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'city-cards.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(35),
     
      child: Column(
        children: [
          Text("Your Statistics",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ))),
          CategoryStatistics(),
        ],
      ),
    );
  }
}

class CategoryStatistics extends StatefulWidget {
  @override
  _CategoryStatisticsState createState() => _CategoryStatisticsState();
}

class _CategoryStatisticsState extends State<CategoryStatistics>
    with SingleTickerProviderStateMixin {
  final List<CategoryData> data = [
    CategoryData('Gastronomy', Icons.local_dining, 0.5),
    CategoryData('Food', Icons.fastfood, 0.7),
    CategoryData("Sport", Icons.sports, 0.3),
    CategoryData("Shopping", Icons.shopping_bag, 0.1),
    CategoryData("Health", Icons.healing, 0.5),
    CategoryData("History", Icons.history, 0.4)
  ];

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
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
    return Container(
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
        data[group.x.toInt()].name +
            '\n' +
            (rod.y * 100).toStringAsFixed(0) +
            '%',
        GoogleFonts.poppins(
          textStyle: TextStyle(color: Color.fromRGBO(44, 87, 116, 100),fontSize: 12,
          fontWeight: FontWeight.w900)
        ),
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
          barGroups: data.asMap().entries.map((entry) {
            final int index = entry.key;
            final CategoryData category = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  y: category.value * _animation.value,
                  colors: [
                    Color.fromRGBO(44, 87, 116, 100),
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
}

class CategoryData {
  final String name;
  final IconData icon;
  final double value;

  CategoryData(this.name, this.icon, this.value);
}
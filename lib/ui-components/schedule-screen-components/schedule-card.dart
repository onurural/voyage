
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/schedule-screen-components/schedule.dart';
import 'package:voyage/views/schedule-view/schedule.view.dart';

class ScheduleCard extends StatefulWidget {
  final Schedule schedule;
  final double? maxHeight;

  const ScheduleCard(this.schedule, {Key? key, this.maxHeight}) : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: IntrinsicHeight(
    child: Container(
    constraints: BoxConstraints(
    maxHeight: widget.maxHeight ?? double.infinity,
    ),
    width: 250,
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
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Stack(
    children: [
    Container(
    decoration: BoxDecoration(
    image: widget.schedule.place.image != null
    ? DecorationImage(
    image:
    MemoryImage(widget.schedule.place.image!.image!),
    fit: BoxFit.cover,
    )
        : null,
    ),
    ), // TODO handle the decoration.
    Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    Colors.black.withOpacity(0.3),
    Colors.black.withOpacity(0.7),
    ],
    ),
    ),
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
    Flexible(
    child: Padding(
    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
    widget.schedule.title,
    style: GoogleFonts.notoSerif(
    textStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    ),
    ),
    ),
    ),
    FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
    widget.schedule.place.name ?? 'nil',
    style: GoogleFonts.notoSerif(
    textStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    ),
    ),
    ),
    ),
    const SizedBox(height: 5),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    RatingBarIndicator(
    rating: widget.schedule.place.rating ?? -1,
    itemBuilder: (context, index) => const Icon(
    Icons.star,
    color: Colors.white,
    ),
    itemCount: 5,
    itemSize: 15,
    direction: Axis.horizontal,
    ),
    Text(
    widget.schedule.place.rating.toString(),
    style: GoogleFonts.roboto(
    textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Colors.white,
    ),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ),
      Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 87, 116, 100),
          borderRadius: BorderRadius.circular(5),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScheduleScreen(
                    schedule: widget.schedule)));
          },
          child: Center(
            child: Text(
              'View',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
    ),
    ],
    ),
    ),
    ),
    ),
    );
  }
}

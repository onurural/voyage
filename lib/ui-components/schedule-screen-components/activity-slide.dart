// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:voyage/ui-components/schedule-screen-components/maps.widget.dart';
import 'package:voyage/ui-components/place-components/description-box.dart';
import 'Activity.dart';

class ActivitySlide extends StatefulWidget {
  final Activity activity;
  final DateFormat timeFormat = DateFormat('hh:mm a');

  ActivitySlide(this.activity, {super.key});

  @override
  State<ActivitySlide> createState() => _ActivitySlideState();
}

class _ActivitySlideState extends State<ActivitySlide>
    with TickerProviderStateMixin {
  bool isContentShown = false;
  bool isDescShowed = false;
  var descButtonIcon = Icons.arrow_downward_rounded;

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 10,
        width: _currentIndex == index ? 30 : 10,
        decoration: BoxDecoration(
          color: _currentIndex == index ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget beautifulTimeContainer(DateTime beginTime, DateTime endTime) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Begin Time',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    )),
                Text(
                  DateFormat('hh:mm a').format(beginTime),
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const VerticalDivider(
              color: Colors.black,
              thickness: 2,
            ),
            Column(
              children: [
                Text(
                  'End Time',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(endTime),
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define the color palette and text styles
    Color primaryColor = const Color.fromRGBO(44, 87, 116, 1);
    Color secondaryColor = const Color.fromRGBO(235, 235, 235, 1);
    TextStyle titleStyle = GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: secondaryColor,
    );
    TextStyle subtitleStyle = GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: secondaryColor.withOpacity(0.8),
    );
    TextStyle descriptionStyle = GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: secondaryColor,
    );
    TextStyle buttonTextStyle = GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      isContentShown = !isContentShown;
                      if (isContentShown) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.activity.title, style: titleStyle),
                          const SizedBox(height: 5),
                          Text(widget.activity.subtitle, style: subtitleStyle),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RatingBarIndicator(
                                rating: widget.activity.rate,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20,
                                direction: Axis.horizontal,
                              ),
                              Text(
                                widget.activity.rate.toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          beautifulTimeContainer(widget.activity.beginTime,
                              widget.activity.endTime)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _animation,
              axisAlignment: -1,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              enlargeCenterPage: true,
                            ),
                            items: widget.activity.photos
                                .map((photo) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            spreadRadius: 1,
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: NetworkImage(photo),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        const MapsWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(0),
                      const SizedBox(width: 10),
                      _buildDot(1),
                    ],
                  ),
                  Container(
                    color: primaryColor,
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              isDescShowed = !isDescShowed;
                              if (isDescShowed == false) {
                                descButtonIcon = Icons.arrow_downward_rounded;
                              } else {
                                descButtonIcon = Icons.arrow_upward_rounded;
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Description',
                                style: descriptionStyle,
                              ),
                              Icon(
                                descButtonIcon,
                                size: 20,
                                color: secondaryColor,
                              )
                            ],
                          ),
                        ),
                        AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild:
                              DescriptionBox(widget.activity.description),
                          crossFadeState: isDescShowed
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        'Get More Information',
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

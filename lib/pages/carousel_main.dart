import 'dart:async';

import 'package:feedback/design/dots_row.dart';
import 'package:feedback/pages/carousel.dart';
import 'package:feedback/design/carousel_details.dart';
import 'package:flutter/material.dart';
import 'carousel.dart';


class CarouselMain extends StatefulWidget {

  @override
  _CarouselMainState createState() => _CarouselMainState();
}

class _CarouselMainState extends State<CarouselMain> {

  double _buttonOpacity = 0;
  int currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0
  );
  dynamic bg = [Colors.blue[600],Colors.brown[600],Colors.orange[600],Colors.pink[400],Colors.green[600],Colors.grey[600],];
  List<int> rating = [1,1,1,1,1,1];
  double elevation = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onRatingChanged(int index,int newRating) {
      rating[index]=newRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 500
            ),
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  if (currentPage !=5)
                    _buttonOpacity = 0.0;
                  else
                    _buttonOpacity = 1.0;
                });
              },
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  color: bg[0],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Carousel(indexDetails: 0,rating: rating[0], onRatingChanged: onRatingChanged),
                        SizedBox(height:50),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bg[1],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Carousel(indexDetails: 1,rating: rating[1],onRatingChanged: onRatingChanged),
                        SizedBox(height:50),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bg[2],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Carousel(indexDetails: 2,rating: rating[2],onRatingChanged: onRatingChanged),
                        SizedBox(height:50),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bg[3],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Carousel(indexDetails: 3,rating: rating[3],onRatingChanged: onRatingChanged),
                        SizedBox(height:50),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bg[4],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Carousel(indexDetails: 4,rating: rating[4],onRatingChanged: onRatingChanged),
                        SizedBox(height:50),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bg[5],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Carousel(indexDetails: 5,rating: rating[5],onRatingChanged: onRatingChanged),
                        SizedBox(height:50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for(int i = 0; i < 6 ; ++i)
                  if(i==currentPage)
                    Dots(focus: true)
                  else
                    Dots(focus: false)
              ],
            ),
          ),
          Positioned(
            bottom: 50,
              child: AnimatedOpacity(
                curve: Curves.fastOutSlowIn,
                opacity: _buttonOpacity,
                duration: Duration(milliseconds: 500),
                child: GestureDetector(
                  child: Text(
                    'NEXT',
                    style: TextStyle(letterSpacing: 1,fontSize: 30,fontFamily: 'Nanami',color: Colors.grey.shade600,shadows: [
                      Shadow(
                        color: Colors.grey.shade700,
                        offset: Offset(1,1),
                        blurRadius: 3.0
                      ),
                      Shadow(
                        color: Colors.grey.shade500,
                        offset: Offset(-1,1),
                        blurRadius: 3.0
                      )
                    ]),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => Navigator.pushReplacementNamed(context, '/result', arguments: {
                    'ratings': rating,
                  }),
                ),
              )
          )
        ],
      ),
    );
  }
}

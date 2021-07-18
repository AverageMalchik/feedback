import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:feedback/design/carousel_details.dart';
import 'package:feedback/design/wave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {

  final int indexDetails;
  late int rating;
  final Function(int,int) onRatingChanged;
  Carousel({required this.indexDetails,required this.rating,required this.onRatingChanged});

  @override
  _CarouselState createState() => _CarouselState(indexDetails);
}

class _CarouselState extends State<Carousel> with SingleTickerProviderStateMixin{

  final List _list = CarouselDetails.carouselList;
  late List<double> heights;
  late AnimationController _controller;

  late double _ratingHeight;
  late double _fixedWidth;
  late int index;

  _CarouselState(int indexDetails) {
    index = indexDetails;
    _fixedWidth = _list[index].waveWidth;
    heights = _list[index].waveHeights;
  }

  @override
  void initState() {

    if (widget.rating < 5)
    _ratingHeight = heights[widget.rating - 1];
    else {
      _opacityWave = 0;
      _ratingHeight = 0;
    }

    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );
    _controller.forward();
    //Timer(Duration(seconds: 1),() => updateContainer());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _opacityWave = 1;

  double height = 550.0;
  double _opacity = 1.0;

  bool flag = true;
  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;
  TextStyle styleDefault = TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold,fontFamily: 'Nanami',shadows: [Shadow(color: Colors.black,blurRadius: 0,offset: Offset(2,2.5))]);
  TextStyle styleDrag = TextStyle(color: Colors.grey[100], fontSize: 50,fontWeight: FontWeight.bold,fontFamily: 'Nanami',shadows: [Shadow(color: Colors.black,blurRadius: 0,offset: Offset(2,2.5))]);

  bool upDrag = true;
  Future<void> increaseRating(int c) async {
    widget.rating += c;
    if (widget.rating < 5) {
      _ratingHeight = heights[widget.rating-1];
    } else if (widget.rating >= 5) {
      widget.rating = 5;
      _opacityWave = 0;
    }
    widget.onRatingChanged(index,widget.rating);
    HapticFeedback.lightImpact();
  }
  Future<void> decreaseRating(int c) async {
    widget.rating-=c;
    if (widget.rating < 1) widget.rating = 1;
    _opacityWave = 1;
    //print(count);
    _ratingHeight = heights[widget.rating-1];
    widget.onRatingChanged(index,widget.rating);
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Column(// before wrapped by slide transition with _offsetAnimation as position
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 100,),
        Container(//this was an animated container
          //duration: Duration(milliseconds: 500),
          //curve: Curves.ease,
          height: height,
          decoration: BoxDecoration(
              color: _list[index].color,
              borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,12,0,2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: [
                        TextSpan(text:_list[index].question[0],style: TextStyle(fontSize: 25,fontFamily: 'Nanami',color: Colors.black)),
                        TextSpan(text:_list[index].question[1],style: TextStyle(shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2,2),
                              blurRadius: 0
                          )
                        ],color: Colors.grey[50],fontFamily: 'Nanami',fontSize: 27)),
                        TextSpan(text:_list[index].question[2],style: TextStyle(fontSize: 25,fontFamily: 'Nanami',color: Colors.black))
                      ]
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: GestureDetector(
                    onVerticalDragStart: (details) {
                      setState(() {
                        flag=!flag;
                        //update = true;
                      });
                      startVerticalDragDetails = details;
                    },
                    onVerticalDragUpdate: (details) {
                      //primaryDelta definitely depends on speed of drag
                      updateVerticalDragDetails = details;
                    },
                    onVerticalDragEnd: (details) async {
                      double dy = updateVerticalDragDetails.globalPosition.dy -
                          startVerticalDragDetails.globalPosition.dy;

                      if (dy < 0) {
                        dy = -dy;
                        upDrag = true;
                      } else {
                        upDrag = false;
                      }

                      if (dy >= 80 && dy <=150) {
                        if (upDrag)
                          await increaseRating(1);
                        else
                          await decreaseRating(1);
                      } else if (dy > 150 && dy <= 300) {
                        if (upDrag)
                          await increaseRating(2);
                        else
                          await decreaseRating(2);
                      } else if (dy >300 && dy <=400) {
                        if (upDrag)
                          await increaseRating(3);
                        else
                          await decreaseRating(3);
                      } else if (dy > 400) {
                        if (upDrag)
                          await increaseRating(4);
                        else
                          await decreaseRating(4);
                      }
                      print('Delta Y\n$dy');
                      setState(() {
                        flag=!flag;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      fit: StackFit.loose,
                      //Use this widget for Can Filled and 2 clipped containers, which are to be moved
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/${_list[index].image}')
                              )
                          ),
                        ),
                        Wave(
                            color: _list[index].color,
                            fixedWidth: _fixedWidth,
                            height: _ratingHeight,
                            opacityWave: _opacityWave,
                            waveHeight: 20.0,
                            factor: 270.0,
                            speed: 540,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Opacity(
                    opacity: _opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 20,
                            color: _list[index].color,
                            child: AnimatedSwitcher(
                              child: flag ? Center(child: Text('${widget.rating}',style: styleDefault,textAlign: TextAlign.center,)) : Center(child: Text('${widget.rating}',style: styleDrag,textAlign: TextAlign.center,)),
                              duration: Duration(milliseconds: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,0,0),
                            child: Text('/5',style: TextStyle(color: Colors.black, fontFamily: 'Nanami',fontSize: 10)),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
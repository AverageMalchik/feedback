import 'dart:async';

import 'package:feedback/design/carousel_details.dart';
import 'package:feedback/design/wave.dart';
import 'package:flutter/material.dart';

class Mini extends StatefulWidget {
  final int index;
  final int rating;
  final double width;
  final double height;

  Mini(
      {required this.index,
      required this.rating,
      required this.width,
      required this.height,
      });

  @override
  _MiniState createState() => _MiniState();
}

class _MiniState extends State<Mini> {
  double _opacity = 1.0;


  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.all(12.0),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/${CarouselDetails.carouselList[widget.index].image}'))),
        ),
        Wave(
          color: Colors.white,
          fixedWidth: widget.width,
          height: (widget.rating == 5) ? 0 : CarouselDetails.carouselList[widget.index].waveHeightsMini[widget.rating - 1] ,
          opacityWave: _opacity,
          waveHeight: 12.0,
          factor: 90,
          speed: 180,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CarouselDetails {
  final Color? color;
  final Color? colorBackground;
  final List<String> question;
  final double waveWidth;
  final List<double> waveHeights;
  final List<double> waveHeightsMini;
  final String image;

  CarouselDetails({required this.color,required this.colorBackground,required this.question,required this.waveWidth,required this.waveHeights,required this.image,required this.waveHeightsMini});

  static List carouselList = [
    CarouselDetails(
        color: Colors.blue[100],
        colorBackground: Colors.blue[600],
        question: ['Did you receive your ','order',' on time?'],
        waveWidth: 200.0,
        waveHeights: [450.0,375.0,300.0,225.0],
        waveHeightsMini: [150,130,100,80],
        image: 'can_filled.png'
    ),
    CarouselDetails(
        color: Colors.brown[100],
        colorBackground: Colors.brown[600],
        question: ['How was the ','condition',' of the packaging?'],
        waveWidth: 200.0,
        waveHeights: [450.0,375.0,300.0,225.0],
        waveHeightsMini: [150,130,100,80],
        image: 'can_filled.png'
    ),
    CarouselDetails(
        color: Colors.orange[100],
        colorBackground: Colors.orange[600],
        question: ['How ','fresh',' were the perishable items?'],
        waveWidth: 200.0,
        waveHeights: [450.0,375.0,300.0,225.0],
        waveHeightsMini: [150,130,100,80],
        image: 'can_filled.png'
    ),
    CarouselDetails(
        color: Colors.pink[100],
        colorBackground: Colors.pink[400],
        question: ['How ','easy',' was our application to use?'],
        waveWidth: 200.0,
        waveHeights: [450.0,375.0,300.0,225.0],
        waveHeightsMini: [150,130,100,80],
        image: 'can_filled.png'
    ),
    CarouselDetails(
        color: Colors.green[100],
        colorBackground: Colors.green[600],
        question: ['How competitive are our ','prices',' compared to other stores?'],
        waveWidth: 200.0,
        waveHeights: [450.0,375.0,300.0,225.0],
        waveHeightsMini: [150,130,100,80],
        image: 'can_filled.png'
    ),
    CarouselDetails(
        color: Colors.grey[100],
        colorBackground: Colors.grey[600],
        question: ['How ','helpful',' is our Customer Service?'],
        waveWidth: 200.0,
        waveHeights: [450.0,375.0,300.0,225.0],
        waveHeightsMini: [150,130,100,80],
        image: 'can_filled.png'
    )
  ];
}
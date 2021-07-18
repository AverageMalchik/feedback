import 'dart:async';

import 'package:feedback/design/mini.dart';
import 'package:feedback/design/result_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map data = {};
  int score = 0;
  int index = 0;
  double _opacity = 0.0;
  double _opacityPop = 0.0;
  bool update = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 200), () => null);
    Timer(Duration(milliseconds: 700), () {
      setState(() {
        _opacity = 1.0;
        _opacityPop = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = 80;
    double _height = 913.0 / 535.0 * _width;
    data = ModalRoute.of(context)!.settings.arguments as Map;
    //print(data['ratings']);
    if (update) {
      for (int i in data['ratings']) score += i;
      update = false;
    }
    //print(score);
    if (score <= 10 && score >= 0)
      index = 0;
    else if (score >= 11 && score <= 20)
      index = 1;
    else if (score >= 21 && score <= 30) index = 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResultWidget(index: index),
            SizedBox(
              height: 20,
            ),
            AnimatedOpacity(
              opacity: _opacityPop,
              duration: Duration(milliseconds: 300),
              child: Container(
                alignment: Alignment.center,
                width: 330,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 60),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    //color: Colors.grey[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 6; i++)
                          Mini(
                              index: i,
                              rating: data['ratings'][i],
                              width: _width,
                              height: _height,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                  opacity: _opacity,
                  child: Text(
                    'Submit another feedback',
                    style: TextStyle(
                        fontFamily: 'NanamiEL',
                        fontSize: 15,
                        color: Colors.black45,
                        letterSpacing: .8),
                    textAlign: TextAlign.center,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

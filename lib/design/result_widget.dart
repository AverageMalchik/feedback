import 'package:flutter/material.dart';

class ResultWidget extends StatefulWidget {
  final int index;

  ResultWidget({required this.index});

  @override
  _ResultWidgetState createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation1 = Tween<Offset>(
    begin: Offset(-1.5,0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));
  late Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: Offset(1.5,0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2500));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.index == 0
        ? TweenAnimationBuilder(
            duration: Duration(seconds: 2),
            tween: ColorTween(begin: Colors.white, end: Colors.red[800]),
            builder: (context, Color? value, child) => Text(
              'We are sorry for your inconvenience',
              style: TextStyle(
                  fontSize: 40, fontFamily: 'NanamiBook', color: value),
              textAlign: TextAlign.center,
            ),
          )
        : widget.index == 1
            ? TweenAnimationBuilder(
                duration: Duration(seconds: 2),
                tween: Tween<double>(begin: 35, end: 40),
                curve: Curves.bounceOut,
                builder: (context, double? value, child) => Container(
                  height: 100,
                  width: 400,
                  //color: Colors.grey[100],
                  child: Center(
                    child: Text(
                      'Hope we serve you better next time',
                      style: TextStyle(
                          fontSize: value,
                          fontFamily: 'NanamiBook',
                          color: Colors.amber[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _offsetAnimation1,
                    child: Text(
                      'We hope you can',
                      style: TextStyle(
                          color: Colors.green[600],
                          fontFamily: 'NanamiBook',
                          fontSize: 40),
                    ),
                  ),
                  SlideTransition(
                    position: _offsetAnimation2,
                    child: Text('come back next time',
                        style: TextStyle(
                            color: Colors.green[600],
                            fontFamily: 'NanamiBook',
                            fontSize: 40)),
                  )
                ],
              );
  }
}

import 'dart:math';

// #enddocregion ShakeCurve
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(LogoApp());

// #docregion diff
class AnimatedLogo extends AnimatedWidget {
// Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 70),
            height: _sizeTween.evaluate(animation),
            width: _sizeTween.evaluate(animation),
            child: Image.asset(
                'images/flower.jpg')
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
// #docregion AnimationController, tweens
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
// #enddocregion AnimationController, tweens
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/HomeScreen.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true, max: 1);

  late final AnimationController _controllerText = AnimationController(
    duration: const Duration(seconds: 6),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: const Offset(0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInToLinear,
  ));
  late final Animation<Offset> _offsetAnimationMiddle = Tween<Offset>(
    begin: const Offset(0, -1),
    end: const Offset(0, 1),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInToLinear,
  ));
  late final Animation<Offset> _offsetAnimationText = Tween<Offset>(
    begin: const Offset(0, 1),
    end: const Offset(0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controllerText,
    curve: Curves.elasticIn,
  ));

  @override
  void initState() {
    super.initState();
    //_controller.forward();
    _controllerText.forward();
    /*_controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });*/
    _controllerText.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerText.stop();
        _controller.stop();
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(title: 'Footprint')),
          );
        });

      }
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFF4F5FC),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/splash_bg.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Row(children: <Widget>[
              Expanded(
                child: SlideTransition(
                    position: _offsetAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/splash_1.png"),
                    )),
              ),
              Expanded(
                child: SlideTransition(
                    position: _offsetAnimationMiddle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/splash_1.png"),
                    )),
              ),
              Expanded(
                child: SlideTransition(
                    position: _offsetAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/splash_1.png"),
                    )),
              ),
            ]),
            Container(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _offsetAnimationText,
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [
                          0.0,
                          0.5,
                          1.0,
                        ],
                        colors: [  const Color(0xFFF4F5FC).withOpacity(0.1), Colors.white.withOpacity(0.9), Colors.white,],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 20.0),
                      child: SvgPicture.asset('assets/splashtext.svg'),
                    )),
              ),
            )
          ],
        )
    );
  }
}

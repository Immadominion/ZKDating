import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zkdating/main.dart';

class ZkDatingSplash extends StatefulWidget {
  const ZkDatingSplash({super.key});

  @override
  ZkDatingSplashState createState() => ZkDatingSplashState();
}

class ZkDatingSplashState extends State<ZkDatingSplash>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation setup
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 12).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );

    // Fade animation setup
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
    );

    // Start fade animation immediately
    _fadeController.forward();

    // Listen for scale animation completion
    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const MyApp(),
          ),
        );
      }
    });

    // Start scale animation after delay
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _scaleController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff412EEF),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 -
                        (_scaleAnimation.value / 14), // Adjust scale factor
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/zkd-logo.png',
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
              // const SizedBox(height: 10),
              // Animated Text
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('ZK Dating',
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        )),
                  ],
                  isRepeatingAnimation: false,
                  displayFullTextOnTap: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

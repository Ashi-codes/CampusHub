import 'dart:async';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double _scale = 0.7;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    /// Fade + Zoom animation
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
        _opacity = 1.0;
      });
    });

    /// Navigate to Welcome Screen
    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WelcomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff0F52FF),
              Color(0xff2563EB),
              Color(0xff4F8DFF),
            ],
          ),
        ),

        child: Stack(

          children: [

            /// Top Right Circle
            Positioned(
              top: -120,
              right: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            /// Bottom Left Circle
            Positioned(
              bottom: -140,
              left: -90,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            /// Extra Soft Circle
            Positioned(
              top: 120,
              left: -60,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            /// Main Content
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 900),
                opacity: _opacity,

                child: AnimatedScale(
                  duration: const Duration(milliseconds: 900),
                  scale: _scale,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /// Logo Card
                      Container(
                        height: 155,
                        width: 155,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(38),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.20),
                              blurRadius: 35,
                              offset: const Offset(0,15),
                            ),
                          ],
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Image.asset(
                            'assets/images/logo.png',
                          ),
                        ),
                      ),

                      const SizedBox(height: 38),

                      /// App Name
                      const Text(
                        'CampusHub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Tagline
                      Text(
                        'Your Smart Campus Companion',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.75),
                          fontSize: 17,
                          letterSpacing: .5,
                        ),
                      ),

                      const SizedBox(height: 55),

                      /// Loading Bar
                      SizedBox(
                        width: 170,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),

                          child: const LinearProgressIndicator(
                            minHeight: 6,
                            backgroundColor: Colors.white24,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// Loading Text
                      Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.75),
                          fontSize: 15,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            /// Version Text
            const Positioned(
              bottom: 30,
              left: 0,
              right: 0,

              child: Center(
                child: Text(
                  'Version 1.0',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
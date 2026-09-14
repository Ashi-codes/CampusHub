import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundEffect extends StatelessWidget {
  const BackgroundEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // Main Background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffEAF3FF),
                Colors.white,
              ],
            ),
          ),
        ),

        // Top Left Circle
        Positioned(
          top: -100,
          left: -120,
          child: _circle(
            250,
            const Color(0xffA9CBFF).withOpacity(.35),
          ),
        ),

        // Top Right Circle
        Positioned(
          top: -80,
          right: -100,
          child: _circle(
            220,
            const Color(0xffB8D5FF).withOpacity(.25),
          ),
        ),

        // Bottom Left
        Positioned(
          bottom: -120,
          left: -90,
          child: _circle(
            250,
            const Color(0xffD6E8FF).withOpacity(.40),
          ),
        ),

        // Bottom Right
        Positioned(
          bottom: -130,
          right: -120,
          child: _circle(
            260,
            const Color(0xffC7DDFF).withOpacity(.35),
          ),
        ),

        // Blur Layer
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
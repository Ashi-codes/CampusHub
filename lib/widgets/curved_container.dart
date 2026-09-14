import 'package:flutter/material.dart';

class CurvedContainer extends StatelessWidget {
  final Widget child;

  const CurvedContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: child,
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(0, 55);

    path.quadraticBezierTo(
      size.width * 0.50,
      -20,
      size.width,
      55,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


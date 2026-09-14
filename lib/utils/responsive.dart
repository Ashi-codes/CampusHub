import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget child;

  const Responsive({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Mobile
    if (width < 600) {
      return child;
    }

    // Tablet / Laptop / Desktop
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: child,
      ),
    );
  }
}
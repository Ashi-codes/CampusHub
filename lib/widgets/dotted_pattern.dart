import 'package:flutter/material.dart';

class DottedPattern extends StatelessWidget {
  final double dotSize;
  final int rows;
  final int columns;

  const DottedPattern({
    super.key,
    this.dotSize = 5,
    this.rows = 7,
    this.columns = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: columns * 14,
      height: rows * 14,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          rows * columns,
              (index) => Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: const Color(0xffA9C8FF),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
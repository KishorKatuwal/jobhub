import 'package:flutter/material.dart';

class WidthSpacer extends StatelessWidget {
  final double width;
  const WidthSpacer({super.key, required this.width,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
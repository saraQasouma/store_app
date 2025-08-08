import 'package:flutter/material.dart';

class ImageGradientOverLayWidget extends StatelessWidget {
  final BorderRadius? borderRadius;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  const ImageGradientOverLayWidget({
    super.key,
    this.borderRadius,
    this.colors = const [
      Color.fromRGBO(0, 0, 0, 0.7),
      Colors.transparent,
    ],
    this.begin = Alignment.bottomCenter,
    this.end = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

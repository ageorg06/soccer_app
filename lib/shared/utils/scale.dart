import 'package:flutter/widgets.dart';

class Scale {
  double _baseWidth = 1280.0;
  double _baseHeight = 840.0;
  late double _screenHeight;
  late double _screenWidth;

  Scale(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
  }

  double height(double size) {
    return (_screenHeight / _baseHeight) * size;
  }

  double width(double size) {
    return (_screenWidth / _baseWidth) * size;
  }

  double get baseHeight => _baseHeight;
}
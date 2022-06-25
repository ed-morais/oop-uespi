import 'dart:math' as math;

import './shape.dart';

class Triangle extends Shape {
  final double _side1;
  final double _side2;
  final double _side3;

  Triangle({
    required double side1,
    required double side2,
    required double side3,
  })  : _side1 = side1,
        _side2 = side2,
        _side3 = side3,
        super(ShapeType.triangle) {
    if ((_side1 + _side2 <= _side3) ||
        (_side1 + _side3 <= _side2) ||
        (_side2 + _side3 <= _side1)) {
      throw Exception('Invalid triangle');
    }
  }

  @override
  String toString() => '$name($_side1,$_side2,$_side3)';

  @override
  double area() {
    final s = perimeter() / 2;
    return math.sqrt(s * (s - _side1) * (s - _side2) * (s - _side3));
  }

  @override
  double perimeter() {
    return _side1 + _side2 + _side3;
  }
}

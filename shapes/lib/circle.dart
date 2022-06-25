import 'dart:math' as math;

import './shape.dart';

class Circle extends Shape {
  final double _radius;

  Circle({required double radius})
      : _radius = radius,
        super(ShapeType.circle);

  @override
  String toString() => '$name($_radius)';

  @override
  double area() => math.pi * _radius * _radius;

  @override
  double perimeter() => 2 * math.pi * _radius;
}

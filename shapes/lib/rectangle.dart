import './shape.dart';

class Rectangle extends Shape {
  final double _height;
  final double _width;

  Rectangle(
      {required double height,
      required double width,
      ShapeType type = ShapeType.rectangle})
      : _height = height,
        _width = width,
        super(type);

  double get height => _height;
  double get width => _width;

  @override
  String toString() => '$name($_height,$_width)';

  @override
  double area() => _height * _width;

  @override
  double perimeter() => 2 * (_height + _width);
}

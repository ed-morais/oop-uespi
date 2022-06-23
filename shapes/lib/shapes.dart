abstract class Shape {
  double area();
  double perimeter();
}

class Rectangle implements Shape {
  final double _height;
  final double _width;

  Rectangle({required double height, required double width})
      : _height = height,
        _width = width;

  @override
  String toString() => 'Rect($_height,$_width)';

  @override
  double area() => _height * _width;

  @override
  double perimeter() => 0.0;
}

class Square extends Rectangle {
  Square({required double width}) : super(height: width, width: width);

  @override
  String toString() {
    return 'Square($_width)';
  }
}

class Circle implements Shape {
  final double _radius;

  Circle({required double radius}) : _radius = radius;

  @override
  String toString() => 'Circle($_radius)';

  @override
  double area() => 3.1415927 * _radius * _radius;

  @override
  double perimeter() => 0.0;
}

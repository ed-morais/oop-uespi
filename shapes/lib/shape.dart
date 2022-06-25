enum ShapeType {
  triangle,
  rectangle,
  square,
  circle,
}

abstract class Shape {
  static const Map<ShapeType, String> _shapeName = {
    ShapeType.triangle: 'Triangle',
    ShapeType.rectangle: 'Rect',
    ShapeType.square: 'Square',
    ShapeType.circle: 'Circle',
  };

  final ShapeType _type;

  Shape(ShapeType type) : _type = type;

  @override
  String toString() => name;

  String get name => Shape._shapeName[_type]!;

  double area();
  double perimeter();
}

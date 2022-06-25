import './shapes.dart';

class Square extends Rectangle {
  Square({required double width})
      : super(
          height: width,
          width: width,
          type: ShapeType.square,
        );

  @override
  String toString() {
    return '$name($width)';
  }
}

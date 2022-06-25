import 'dart:math';

import './shapes.dart';

int random(int min, int max) => min + Random().nextInt((max - min).abs() + 1);

void showShapes(List<Shape> shapes) {
  print('SHAPES\t\tAREA\tPERIMETER');
  for (var i = 0; i < shapes.length; i++) {
    final area = shapes[i].area();
    final perimeter = shapes[i].perimeter();
    print(
        '${shapes[i]}\t${area.toStringAsFixed(2)}\t${perimeter.toStringAsFixed(2)}');
  }
}

void main() {
  List<Shape> shapes = [];

  for (int i = 0; i < 10; i++) {
    Shape? shape;

    final int number = random(0, 100);
    final double s1 = random(5, 15).toDouble();
    final double s2 = random(5, 15).toDouble();
    final double s3 = random(5, 15).toDouble();

    if (number < 25) {
      try {
        shape = Triangle(
          side1: s1,
          side2: s2,
          side3: s3,
        );
      } catch (error) {}
    } else if (number < 50) {
      shape = Rectangle(
        height: s1,
        width: s2,
      );
    } else if (number < 75) {
      shape = Square(width: s2);
    } else {
      shape = Circle(radius: s1);
    }
    if (shape != null) {
      shapes.add(shape);
    }
  }
  showShapes(shapes);
}

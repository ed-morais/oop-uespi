import 'dart:math';
import './shapes.dart';

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
  Random rnd = Random();
  List<Shape> shapes = [];

  for (int i = 0; i < 10; i++) {
    final int number = rnd.nextInt(101);
    final int h = 5 + rnd.nextInt(11); // h = 5~15
    final int w = 5 + rnd.nextInt(11); // w = 5~15

    if (number < 30) {
      final Rectangle rect = Rectangle(
        height: h.toDouble(),
        width: w.toDouble(),
      );
      shapes.add(rect);
    } else if (number < 60) {
      final Square sqre = Square(width: w.toDouble());
      shapes.add(sqre);
    } else {
      final Circle circle = Circle(radius: h.toDouble());
      shapes.add(circle);
    }
  }
  showShapes(shapes);
}

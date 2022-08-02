import 'package:aval1/equation.dart';
import 'package:aval1/geometric_progression.dart';
import 'package:aval1/linear_system.dart';

void geometricProgression() {
  final gp1 = GeometricProgression(first: 1, ratio: 2, maxTerms: 10);
  final gp2 = GeometricProgression(first: -2, ratio: 0.5);

  print(gp1);
  print('gp1.termAt(5): ${gp1.termAt(5)}');
  print('gp1.sumOf(5) : ${gp1.sumOf(15)}');

  print('-' * 40);

  print('gp2.termAt(5): ${gp2.termAt(5)}');
  print('gp2.sumOf(5) : ${gp2.sumOf(5)}');
}

void equations() {
  final List<double> coefs = [];

  Equation eq = Equation(
    coeficients: [1, -5, 7, -3, 8],
    independentTerm: 10,
  );
  Equation eq5 = eq * 5;
  Equation eq10 = eq * 10;

  // print(eq);
  // print(eq10);

  final system = LinearSystem([eq, eq5, eq10]);
  print(system);
}

void main() {
  equations();
}

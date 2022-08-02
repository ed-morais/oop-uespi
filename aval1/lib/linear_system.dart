import 'equation.dart';

class LinearSystem {
  final List<Equation> system = [];

  LinearSystem([
    List<Equation>? equations,
  ]) {
    if (equations != null) {
      system.addAll(equations);
    }
  }

  @override
  String toString() => system.join('\n');
}

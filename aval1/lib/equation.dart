class Equation {
  final List<num> coeficients = [];
  final num independentTerm;

  Equation({
    required coeficients,
    required this.independentTerm,
  }) {
    this.coeficients.addAll(coeficients);
  }

  @override
  String toString() {
    int index = 0;
    final terms = coeficients.map<String>((coef) {
      index++;
      return '${(coef > 0) && (index > 1) ? '+' : ''}${coef}x$index';
    });
    return '${terms.toList().join(" ")} = $independentTerm';
  }

  Equation operator *(num factor) {
    return Equation(
      coeficients: coeficients.map<num>(
        (coef) => coef * factor,
      ),
      independentTerm: independentTerm * factor,
    );
  }
}

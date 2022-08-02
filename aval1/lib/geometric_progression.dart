import 'dart:math';

class GeometricProgression {
  final num first;
  final num ratio;
  final int? maxTerms;

  GeometricProgression({
    required this.first,
    required this.ratio,
    this.maxTerms,
  });

  @override
  String toString() {
    return 'GeometricProgression($first,$ratio)';
  }

  bool get isFinite => maxTerms != null;

  bool get isInfinite => maxTerms == null;

  num termAt(int index) {
    if ((index <= 0) || (isFinite && (index > maxTerms!))) {
      throw RangeError('GP term index out of range: $index');
    }
    return first * pow(ratio, index - 1);
  }

  num sumOf(int n) {
    if ((n < 0) || (isFinite && (n > maxTerms!))) {
      throw ArgumentError('Invalid number of GP terms: $n');
    }
    return first * (1 - pow(ratio, n)) / (1 - ratio);
  }
}

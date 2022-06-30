class Currency {
  static const int _decimalPlaces = 2;
  static const int _pow10 = 100;
  static const String _decimalSeparator = '.';

  final int _value;

  Currency(num value) : _value = (value * _pow10).toInt();

  const Currency._raw(int value) : _value = value;

  @override
  String toString() {
    final int integer = _value ~/ _pow10;
    final String decimal =
        (_value % _pow10).toString().padLeft(_decimalPlaces, '0');
    return '$integer${Currency._decimalSeparator}$decimal';
  }

  Currency operator +(Currency curr) => Currency._raw(_value + curr._value);
  Currency operator -(Currency curr) => Currency._raw(_value - curr._value);
  Currency operator *(Currency curr) =>
      Currency._raw((_value * curr._value) ~/ _pow10);
  Currency operator /(Currency curr) =>
      Currency._raw(((_value * _pow10) ~/ (curr._value * _pow10)));

  bool operator <(Currency curr) => _value < curr._value;
  bool operator >(Currency curr) => _value > curr._value;
  bool operator <=(Currency curr) => _value <= curr._value;
  bool operator >=(Currency curr) => _value >= curr._value;

  @override
  bool operator ==(Object curr) {
    return (curr is Currency) && (_value == curr._value);
  }

  @override
  int get hashCode => _value;
}

void main() {
  Currency c1 = Currency(5);
  Currency c2 = Currency(13.5);
  Currency c3 = Currency(27.98);

  print('c1 = $c1');
  print('c2 = $c2');
  print('c3 = $c3');
  print('c1 + c2 = ${c1 + c2}');
  print('c1 - c2 = ${c1 - c2}');
  print('c1 * c2 = ${c1 * c2}');
  print('c2 / c1 = ${c2 / c1}');
  print('----------');
  print('c1 < c2 = ${c1 < c2}');
  print('c1 > c2 = ${c1 > c2}');
  print('c1 <= c2 = ${c1 <= c2}');
  print('c1 >= c2 = ${c1 >= c2}');
  print('----------');
  print('c1.hasCode = ${c1.hashCode}');
  print('c2.hasCode = ${c2.hashCode}');
  print('c1 == c2 = ${c1 == c2}');
}

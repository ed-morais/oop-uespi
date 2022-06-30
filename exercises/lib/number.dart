import 'dart:math' as math;

class Number {
  final int _number;

  Number([this._number = 0]);

  @override
  String toString() {
    return '$_number';
  }

  bool get isZero => _number == 0;
  bool get isPositive => _number > 0;
  bool get isNegative => _number < 0;
  bool get isEven => (_number % 2) == 0;
  bool get isOdd => (_number % 2) == 1;

  bool get isPrime {
    for (int d = 2; d < _number; d++) {
      if (_number % d == 0) {
        return false;
      }
    }
    return true;
  }

  bool get isArmstrong {
    int digs = digitCount();
    int nbr = _number;
    int sum = 0;
    int d;

    do {
      d = nbr % 10;
      sum += math.pow(d, digs).floor();
      nbr ~/= 10;
    } while (nbr != 0);

    return sum == _number;
  }

  int digitCount([int base = 10]) {
    int nbr = _number;
    int digs = 0;

    do {
      nbr ~/= base;
      digs++;
    } while (nbr != 0);

    return digs;
  }

  int digitSum([int base = 10]) {
    int nbr = _number;
    int sum = 0;

    do {
      sum += nbr % base;
      nbr ~/= base;
    } while (nbr != 0);

    return sum;
  }

  int get factorial {
    int f = 1;

    for (int k = 2; k <= _number; k++) {
      f *= k;
    }
    return f;
  }

  double get sqrt => math.sqrt(_number);
  int get sqr => _number * _number;

  int get mirror {
    int nbr = _number;
    int sum = 0;
    int p;

    p = math.pow(10, digitCount() - 1).floor();
    do {
      sum += (nbr % 10) * p;
      nbr ~/= 10;
      p ~/= 10;
    } while (nbr != 0);

    return sum;
  }

  String asBase([int base = 10]) {
    int nbr = _number;
    String result = '';

    String digit(int value) {
      int offset;

      if ((value >= 0) && (value <= 9)) {
        offset = 48;
      } else if ((value >= 10) && (value <= 35)) {
        offset = 55;
      } else {
        return '';
      }
      return String.fromCharCode(offset + value);
    }

    do {
      result = digit(nbr % base) + result;
      nbr = nbr ~/ base;
    } while (nbr != 0);

    return result;
  }
}

void main() {
  Number zero = Number();
  Number ten = Number(10);
  Number prime = Number(17);
  Number arms = Number(371);

  print('zero  = $zero');
  print('ten   = $ten');
  print('prime = $prime\n');

  print('isZero($ten)\t: ${ten.isZero}');
  print('isPositive($ten)\t: ${ten.isPositive}');
  print('isNegative($ten)\t: ${ten.isNegative}');
  print('isEven($ten)\t: ${ten.isEven}');
  print('isOdd($ten)\t: ${ten.isOdd}');
  print('isPrime($ten)\t: ${ten.isPrime}');
  print('isPrime($prime)\t: ${prime.isPrime}');
  print('isArmtrong($arms)\t: ${arms.isArmstrong}');
  print('digCount($arms)\t: ${arms.digitCount()}');
  print('$ten!\t: ${ten.factorial}');
  print('mirror($arms)\t: ${arms.mirror}');
  print('asBase($arms, 2)\t: ${arms.asBase(2)}');
}



/* Rational
 *   Q = { a/b ; a,b in Z e b != 0 }
 */
class Rational {
  int _num;
  int _den;
  
  Rational([this._num = 0, this._den = 1]) {
    if(_den == 0) {
      throw Exception('Invalid rational number: Rational($_num, $_den)');
    }
    
    _normalize();
  }
    
  void _normalize() {
    int div = 2;
    int absMin;
    
    if(_den < 0) {
      _num = -_num;
      _den = -_den;
    }
    
    absMin = _num.abs() < _den.abs() ? _num.abs() : _den.abs();
    while(div <= absMin) {

      if((_num % div == 0) && (_den % div == 0)) {
        _num = _num ~/ div;   // divisão inteira
        _den = _den ~/ div;
        absMin = _num.abs() < _den.abs() ? _num.abs() : _den.abs();

      }
      else {
        div++;
      } 
    }
  }
  
  @override
  String toString() {
    return '$_num/$_den';
  }
    
  // Cria um clone (cópia) de thi s
  Rational copy() => Rational(_num, _den);
   
  // Menos unário
  Rational operator-() {
    return Rational(-_num, _den);  
  }

  // Soma de dois racionais
  Rational operator+(Rational r) {
    return Rational (
      _num*r._den + r._num*_den, 
      _den*r._den
    );
  }
 
  // Subtração de dois racionais
  Rational operator-(Rational r) {
    return Rational (
      _num*r._den - r._num*_den, 
      _den*r._den
    );
  }

  // Multiplicação de dois racionais
  Rational operator*(Rational r) {
    return Rational (
      _num*r._num,
      _den*r._den
    );
  }

  // Divisão de dois racionais
  Rational operator/(Rational r) {
    return Rational (
      _num*r._den,
      _den*r._num
    );
  }
  
  // Inversão de um racional
  Rational invert() {
    return Rational(_den, _num);
  }
  
  /* Comparação de números racionais
   * r1.cmp(r2)
   *   < 0 : r1 < r2
   *   = 0 : r1 = r2
   *   > 0 : r1 > r2
   */
  int cmp(Rational r) {
    double r1 = _num / _den;
    double r2 = r._num / r._den;

    return (r1 > r2) ?  1 : 
           (r1 < r2) ? -1 : 0;    
  }
  
  bool operator>(Rational r) => cmp(r) > 0;
  bool operator<(Rational r) => cmp(r) < 0;
  bool operator>=(Rational r) => cmp(r) >= 0;
  bool operator<=(Rational r) => cmp(r) <= 0;
}

/* RationalSet
 * Implementa um conjunto de números racionais
 */
class RationalSet {
  final List<Rational> _set = [];
 
  int get length => _set.length;
  
  @override
  String toString() {
    String s = _set.toString();
    return '{${s.substring(1, s.length - 1)}}';
  }
 
  bool contains(Rational r) {
    for(var e in _set) {
      if(e.cmp(r) == 0) {
        return true;
      }
    }
    return false;
  }
  
  void add(Rational r) {
    if(!contains(r)) {
      _set.add(r);
    }
  }
  
  /*
  bool remove(Rational r) {
    for(int i=0; i < _set.length; i++) {
      if(r.cmp(_set[i]) == 0) {
        _set.removeAt(i);
        return true;
      }
    }
    return false;
  }
  */
  void remove(Rational r) {
    _set.removeWhere( (e) => e.cmp(r) == 0 );
  }
  
  RationalSet operator+(RationalSet s) {
    RationalSet u = RationalSet();
    
    for(var e in _set) {
      u.add(e);
    }
    for(var e in s._set) {
      u.add(e);
    }
    return u;
  }
  
  RationalSet operator*(RationalSet s) {
    RationalSet t = RationalSet();
    
    for(var e in _set) {
      if(s.contains(e)) {
        t.add(e);
      }
    }
    return t;
  }
  
  RationalSet operator-(RationalSet s) {
    RationalSet d = RationalSet();
    
    for(var e in _set) {
      if(!s.contains(e)) {
        d.add(e);
      }
    }
    return d;
  }
  
  bool isSubSet(RationalSet s) {
    for(var e in _set) {
      if(!s.contains(e)) {
        return false;
      }
    }
    return true;
  }
  
  bool isSuperSet(RationalSet s) {
    return s.isSubSet(this);
  }
  
  bool equal(RationalSet s) {
    if(length != s.length) {
      return false;
    } 
    for(var e in _set) {
      if(!s.contains(e)) {
        return false;
      }
    }
    return true;
  }
  
  bool notEqual(RationalSet s) => !equal(s);
}

void main() {
  Rational r1 = Rational(4,3); 
  Rational r2 = Rational(5,8);  
  Rational r3 = Rational(7,3); 
  Rational r4 = Rational(-4,3); 
  Rational r5 = Rational(8,-3); 
  Rational r6 = Rational(15,9); 
  
  RationalSet s1 = RationalSet();
  RationalSet s2 = RationalSet();

  //s1.add(r1);  
  s1.add(r2);
  s1.add(r3);
  //s1.add(r4);
  print('s1: $s1');

  s2.add(r2);  
  s2.add(r5);
  s2.add(r6);
  s2.add(r3);
  print('s2: $s2');

  // RationalSet u = s1 + s2;
  // print('s1 + s2: $u');
  print('s1 + s2: ${s1 + s2}');
  print('s1 * s2: ${s1 * s2}');
  print('s1 - s2: ${s1 - s2}');
  print('s2 - s1: ${s2 - s1}');
  print('s1 = s2: ${s1.equal(s2)}');
  
  print('s1 é subcj de s2: ${s1.isSubSet(s2)}');
  print('s2 é subcj de s1: ${s2.isSubSet(s1)}');

  print('s1 é supercj de s2: ${s1.isSuperSet(s2)}');
  print('s2 é supercj de s1: ${s2.isSuperSet(s1)}');
}



/*
 * Implemente uma classe que represente uma DATA
 * ATRIBUTOS
 * - dia
 * - mês
 * - ano
 * MÉTODOS
 * + construtor
 * + exbir a data formatada (dd/mm/aaaa)
 * + alterar a data
 * + comparar datas
 */

class Date {
  // Atributo de classe
  static String _separator = '-';
  
  static final _monthNames = [
    'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
    'jul', 'ago', 'set', 'out', 'nov', 'dez',
  ];
  
  // Atributos de instância
  int _day;
  int _month;
  int _year;
  
  // Construtor
  Date(this._year, this._month, this._day);

  // Getter de classe
  static String get separator => Date._separator;
  
  // Getters de instância
  int get day => _day;
  int get month => _month;
  int get year => _year;
  
  String get monthName => _monthNames[_month - 1];
 
  // A data está em um ano bissexto?
  bool get isLeapYear => (_year % 400 == 0) || 
                         ((_year % 4 == 0) && 
                          (_year % 100 != 0));
  /*
  String get monthName {
    final String name;
    
    switch(_month) {
      case 1: name = 'jan'; break;
      case 2: name = 'fev'; break;
      case 3: name = 'mar'; break;
      case 4: name = 'abr'; break;
      case 5: name = 'mai'; break;
      case 6: name = 'jun'; break;
      case 7: name = 'jul'; break;
      case 8: name = 'ago'; break;
      case 9: name = 'set'; break;
      case 10: name = 'out'; break;
      case 11: name = 'nov'; break;
      default: name = 'dez'; break;
    }
    return name;
  }
  */

  // Setter de classe
  static set separator(String s) => _separator = s;
  
  // Setters de instância
  set day(int d) => _day = (d >= 1 && d <= 31) ? d : _day; 
  set month(int m) => _month = (m >= 1 && m <= 12) ? m : _month; 
  set year(int y) => _year = (y >= 0) ? y : _year; 
  
  // Método de classe
  static bool isValid(int y, int m, int d) {
    return (y >= 0) && (m >= 1) && (m <= 12) && (d >= 1) && (d <= 31);
  }
  
  // Método de instância
  void setDate(int y, int m, int d) {
    if(isValid(y, m, d)) {
      _year = y;
      _month = m;
      _day = d;
    }
  }
  
  /*
   * Retorna:
   *   < 0 --> this < date
   *   = 0 --> this = date
   *   > 0 --> this > date
   */
  int compare(Date date) {
    if(_year == date._year) {
      if(_month == date._month) {
        if(_day == date._day) {
          return 0;
        }
        else {
          return _day - date._day;
        }
      }
      else {
        return _month - date._month;
      }
    }
    else {
      return _year - date._year;
    }
  }

  bool operator>(Date date) {
    return compare(date) > 0;
  }
  bool operator<(Date date) {
    return compare(date) < 0;
  }
  bool operator>=(Date date) {
    return compare(date) >= 0;
  }
  bool operator<=(Date date) {
    return compare(date) <= 0;
  }

  Date nextDay() {
    if(_day == 31) {
      _day = 1;
      if(_month == 12) {
        _month = 1;
        _year++;
      } else {
        _month++;
      }
    }
    else {
      _day++;
    }
    
    return this;
  }
  
  Date clone() => Date(_year, _month, _day);
  
  @override
  String toString() {
    final sday = _day.toString().padLeft(2,'0');
    final smonth = _month.toString().padLeft(2,'0');
    final syear = _year.toString().padLeft(2,'0');
    return '$sday$_separator$smonth$_separator$syear';
  }
}

void main() {
  Date d1 = Date(1996, 12, 12);
  Date d2 = Date(2024, 10, 10);

  print('$d1 < $d2: ${d1 < d2}');
  print('$d1 > $d2: ${d1 > d2}');
  print('$d1 <= $d2: ${d1 <= d2}');
  print('$d1 >= $d2: ${d1 >= d2}');
  print('-------------------');  
  
  print('d1: $d1');
  d1.nextDay();
  print('d1: $d1');
  print('-------------------');  
  
  print('$d1: ${d1.monthName}');
  print('$d2: ${d2.monthName}');
  print('-------------------');  
  
  print('$d1 bissexto: ${d1.isLeapYear}');
  print('$d2 bissexto: ${d2.isLeapYear}');
  print('-------------------');  
  
  print('d1: $d1');
  print('d2: $d2');
  d2 = d1.clone();
  d1.nextDay();
  print('d1: $d1');
  print('d2: $d2');
}


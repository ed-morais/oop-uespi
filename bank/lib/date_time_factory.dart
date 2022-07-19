import 'dart:math';

class DateTimeFactory {
  static final _rnd = Random();
  static const _timeInHours = 72;
  static var _lastDateTime = DateTime(2020);

  static void setInitialDateTime(DateTime date) {
    _lastDateTime = date;
  }

  static DateTime random() {
    final duration = Duration(
      hours: _rnd.nextInt(_timeInHours + 1),
    );
    final date = _lastDateTime.add(duration);
    _lastDateTime = date;
    return date;
  }
}

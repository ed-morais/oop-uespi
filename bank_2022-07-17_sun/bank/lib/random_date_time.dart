import 'dart:math';

class RandomDateTime extends DateTime {
  static Random rnd = Random();
  static DateTime _lastDateTime = DateTime(2020);
  static int _deltaDuration = 72;
  static bool _fakeDateTime = true;

  RandomDateTime(int year,
      [int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int milisecond = 0,
      int microsecond = 0])
      : super(
          year,
          month,
          day,
          hour,
          minute,
          second,
          milisecond,
          microsecond,
        );

  factory RandomDateTime.random({DateTime? baseDate, int? deltaInHours}) {
    _deltaDuration = deltaInHours ?? _deltaDuration;
    _lastDateTime = baseDate ?? _lastDateTime;

    final duration = Duration(hours: rnd.nextInt(_deltaDuration + 1));
    _lastDateTime = _lastDateTime.add(duration);

    return RandomDateTime(
      _lastDateTime.year,
      _lastDateTime.month,
      _lastDateTime.day,
      _lastDateTime.hour,
      _lastDateTime.minute,
      _lastDateTime.second,
      _lastDateTime.millisecond,
      _lastDateTime.microsecond,
    );
  }

  static bool get fake => _fakeDateTime;
  static set fake(bool flag) => _fakeDateTime = fake;

  static set deltaDuration(int duration) => _deltaDuration = duration;
}

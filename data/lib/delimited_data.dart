part of 'exchange.dart';

abstract class DelimitedData extends Data {
  String get delimiter;

  @override
  String get data {
    return _data.fold<String>(
      '${_fields.join(delimiter)}\n',
      (lastValue, elem) => '$lastValue${elem.values.join(delimiter)}\n',
    );
  }

  @override
  set data(String string) {
    final lines = string.split(RegExp(r'\n|\r|\r\n'));

    int row = 0;
    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) {
        continue;
      }

      final info = line.split(delimiter);
      final map = <String, dynamic>{};

      if (row > 0) {
        map.clear();
        for (int i = 0; i < _fields.length; i++) {
          map[_fields[i]] = info[i];
        }
        _data.add(map);
      } else {
        _fields.addAll(info);
      }
      row++;
    }
  }
}

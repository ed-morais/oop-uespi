part of 'exchange.dart';

abstract class DelimitedData extends Data {
  String get delimiter;
  String get formatName;

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

    try {
      final fields = lines.first.split(delimiter);

      if (fields.any((field) => num.tryParse(field) != null)) {
        throw InvalidFormat('Invalid $formatName header');
      }

      _fields.clear();
      _fields.addAll(fields);
    } finally {
      clear();
    }

    for (int i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) {
        continue;
      }

      final info = line.split(delimiter);
      final map = <String, dynamic>{};

      map.clear();
      for (int i = 0; i < _fields.length; i++) {
        map[_fields[i]] = info[i];
      }
      _data.add(map);
    }
  }
}

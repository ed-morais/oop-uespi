part of 'exchange.dart';

class JsonData extends Data {
  @override
  String get data {
    return jsonEncode(_data);
  }

  @override
  set data(String string) {
    final decodedData = jsonDecode(string);

    if (decodedData is! List) {
      throw InvalidFormat('Invalid format: not a JSON list');
    }

    if (decodedData.any((entry) => entry is! Map)) {
      throw InvalidFormat('Invalid format: list element is not an object');
    }

    clear();

    for (var entry in decodedData) {
      _data.add(entry);

      for (var field in entry.keys) {
        if (!_fields.contains(field)) {
          _fields.add(field);
        }
      }
    }
  }
}

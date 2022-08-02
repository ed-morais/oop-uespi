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
      throw InvalidFormat();
    }

    clear();

    final entries = decodedData.map((elem) {
      return (elem as Map).map<String, String>(
        (key, value) => MapEntry(
          key.toString(),
          value.toString(),
        ),
      );
    });
    _data.addAll(entries);
  }
}

part of 'exchange.dart';

class XmlData extends Data {
  static const headerElement = '<?xml version="1.0" encoding="UTF-8"?>';
  static const dataElemName = 'data';
  static const recordElemName = 'record';

  @override
  String get data {
    String xml = '$headerElement\n';

    xml += '<$dataElemName>\n';
    for (var elem in _data) {
      final record = elem.entries.fold<String>(
        '  <$recordElemName ',
        (lastValue, entry) {
          final quote = entry.value is num ? '' : '"';
          return '$lastValue${entry.key}=$quote${entry.value}$quote ';
        },
      );
      xml += '$record/>\n';
    }
    xml += '</$dataElemName>\n';

    return xml;
  }

  @override
  set data(String string) {
    final xml = XmlDocument.parse(string);
    final dataElem = xml.getElement(dataElemName);

    if (dataElem == null) {
      throw InvalidFormat('Invalid XML format: "data" element not found');
    }

    final records = dataElem.childElements;
    if (records.any((elem) => elem.localName != recordElemName)) {
      throw InvalidFormat('Invalid XML format: invalid element name');
    }

    clear();

    for (var elem in records) {
      final map = <String, dynamic>{};
      for (var attr in elem.attributes) {
        map[attr.localName] = attr.value;

        if (!_fields.contains(attr.localName)) {
          _fields.add(attr.localName);
        }
      }
      _data.add(map);
    }
  }
}

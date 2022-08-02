import 'dart:io';
import 'package:xml/xml.dart';

void main() {
  final content = File('sample.xml').readAsStringSync();
  final xml = XmlDocument.parse(content);
  final records = xml.findAllElements('record');

  for (var record in records) {
    print(record.name);
    for (var attr in record.attributes) {
      print('- ${attr.name}: ${attr.value}');
    }
  }

  print('-' * 80);

  final xml1 = XmlBuilder();
  xml1.processing('xml', 'version=1.0 encoding=utf-8');
  xml1.element('data', nest: () {
    xml1.element('record', nest: () {
      xml1.attribute('id', '1020');
      xml1.attribute('name', 'Ana Célia Cardoso');
      xml1.attribute('email', 'ana.celia@email.com');
      xml1.attribute('phone', '86994419010');
    });
  });

  final text = xml1.buildDocument().toString();
  print(text);

  final file = File('x.xml');
  file.createSync();
  file.writeAsStringSync(text);
}

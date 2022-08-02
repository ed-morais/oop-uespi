import 'dart:convert';
import 'dart:io';

void main() {
  final content = File('sample.json').readAsStringSync();
  final json = jsonDecode(
    content,
    reviver: (key, value) {
      if (value is List) {
        return value;
      } else {
        return <String, String>{
          key.toString(): value.toString(),
        };
      }
    },
  );

  print(json);

  final data = [
    {
      'id': 1020,
      'name': 'Ana Célia Souza',
      'email': 'ana.celia@email.com',
      'phone': '86994431010',
    },
    {
      'id': 3040,
      'name': 'Chico Berto',
      'email': 'chico@email.com',
      'phone': '86994436622',
    },
  ];

  final encoded = jsonEncode(data);
  final file = File('x.json');
  file.createSync();
  file.writeAsStringSync(encoded);
}

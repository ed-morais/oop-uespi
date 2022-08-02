import 'package:data/exchange.dart';

void main() {
  final json = JsonData();

  json.load('files/sample.json');

  print(json.data);
}

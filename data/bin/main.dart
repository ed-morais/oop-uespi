import 'package:data/exchange.dart';

void main() {
  final json = JsonData();
  json.load('files/sample.json');
  //print(json.data);

  final csv = CsvData();
  csv.load('files/sample.csv');
  //print(csv.data);

  final tsv = TsvData();
  tsv.load('files/sample.tsv');
  //print(tsv.data);

  final xml = XmlData();
  xml.load('files/sample.xml');
  print(xml.data);
}

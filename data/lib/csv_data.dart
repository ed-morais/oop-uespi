part of 'exchange.dart';

class CsvData extends DelimitedData {
  @override
  String get delimiter => ',';

  @override
  get formatName => 'CSV';
}

part of 'exchange.dart';

class TsvData extends DelimitedData {
  @override
  get delimiter => '\t';

  @override
  get formatName => 'TSV';
}

enum StringAlignment {
  left,
  center,
  right,
}

String dateToDDMM(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final mon = date.month.toString().padLeft(2, '0');
  return '$day/$mon';
}

String dateToDDMMYY(DateTime date) {
  return '${dateToDDMM(date)}/${date.year % 100}';
}

DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

String formatString(String s, int width,
    {StringAlignment alignment = StringAlignment.left}) {
  if (s.length > width) {
    return s.substring(0, width);
  }

  String result;

  switch (alignment) {
    case StringAlignment.right:
      result = s.padLeft(width);
      break;
    case StringAlignment.center:
      final diff = (width > s.length) ? width - s.length : 0;
      result = s.padLeft(s.length + diff ~/ 2);
      result = result.padRight(result.length + diff ~/ 2);
      break;
    default:
      result = s.padRight(width);
  }
  return result;
}

String formatNumber(double value, int width, {bool addSuffix = true}) {
  String result =
      value.abs().toStringAsFixed(2).replaceFirst(RegExp(r'\.'), ',');
  if (addSuffix) {
    result = result + ((value < 0) ? 'D' : 'C');
  }
  return result.padLeft(width);
}

double doubleToCurrency(double value) {
  return (value * 100.00).toInt() / 100.00;
}

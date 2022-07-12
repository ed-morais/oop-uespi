String dateToDDMM(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final mon = date.month.toString().padLeft(2, '0');
  return '$day/$mon';
}

String stringWidth(String s, int width) {
  return (s.length > width) ? s.substring(0, width) : s.padRight(width);
}

String formatNumber(double value, int width) {
  String result =
      value.abs().toStringAsFixed(2).replaceFirst(RegExp(r'\.'), ',');
  result = result + ((value < 0) ? 'D' : 'C');
  return result.padLeft(width);
}

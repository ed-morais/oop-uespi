import 'dart:math';

String dateToDDMM(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final mon = date.month.toString().padLeft(2, '0');
  return '$day/$mon';
}

String dateToDDMMYY(DateTime date) {
  return '${dateToDDMM(date)}/${date.year % 100}';
}

String formatString(String s, int width) {
  return (s.length > width) ? s.substring(0, width) : s.padRight(width);
}

String formatNumber(double value, int width, {bool addSuffix = true}) {
  String result =
      value.abs().toStringAsFixed(2).replaceFirst(RegExp(r'\.'), ',');
  if (addSuffix) {
    result = result + ((value < 0) ? 'D' : 'C');
  }
  return result.padLeft(width);
}

DateTime randomDateTime() {
  Random rnd = Random();

  return DateTime(
    2022,
    rnd.nextInt(12) + 1,
    rnd.nextInt(28) + 1,
  );
}

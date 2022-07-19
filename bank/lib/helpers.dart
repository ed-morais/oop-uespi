import 'dart:math';

enum StringAlignment {
  left,
  center,
  right,
}

String alignString(
  String text,
  int width, {
  StringAlignment align = StringAlignment.left,
}) {
  if (text.length > width) {
    return text.substring(0, width);
  }

  String result;

  switch (align) {
    case StringAlignment.right:
      result = text.padLeft(width, ' ');
      break;

    case StringAlignment.center:
      final padding = (width - text.length) ~/ 2;
      result = text.padLeft(text.length + padding, ' ');
      result = result.padRight(result.length + padding, ' ');
      break;

    default:
      result = text.padRight(width, ' ');
  }

  return result;
}

String dateToDDMM(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final mon = date.month.toString().padLeft(2, '0');
  return '$day/$mon';
}

String dateToDDMMYY(DateTime date) {
  return '${dateToDDMM(date)}/${date.year % 100}';
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

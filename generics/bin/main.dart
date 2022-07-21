void main() {
  final numbers = [10, 20, 30, 40, 50];
  final doubles = [1.1, 2.2, 3.3, 4.4, 5.5];

  int sum;

  print(numbers);

  sum = 0;
  for (int i = 0; i < numbers.length; i++) {
    sum += numbers[i];
  }
  print('sum1: $sum');

  sum = 0;
  for (var v in numbers) {
    sum += v;
  }
  print('sum2: $sum');

  sum = 0;
  numbers.forEach((int v) {
    sum += v;
  });
  print('sum3: $sum');

  sum = numbers.fold<int>(
    0,
    (p, v) => p + v,
  );
  print('sum4: $sum');

  String text;

  text = numbers.fold<String>('', (t, v) => '$v$t');
  print(text);
}

void callback<T>(T v) {
  print('-$v- ');
}

void callbackInt(int v) {
  print('*$v* ');
}

void callbackDouble(double v) {
  print('#$v# ');
}

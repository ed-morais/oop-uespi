class Stack<T> {
  final List<T> _stack = [];
  final int size;

  Stack([this.size = 0]);

  bool get isEmpty => _stack.isEmpty;
  bool get isNotEmpty => _stack.isNotEmpty;
  bool get isFull => (size > 0) && (_stack.length == size);

  void push(T data) {
    if (isFull) {
      throw Exception('Stack overflow');
    }
    _stack.add(data);
  }

  T pop() {
    if (isEmpty) {
      throw Exception('Stack underflow');
    }
    return _stack.removeLast();
  }

  @override
  String toString() => 'Stack($size) $_stack';
}

// retorna o número de caracteres dos elementos de [stack]
int operation<T>(Stack<T> stack) {
  int charCount = 0;

  while (stack.isNotEmpty) {
    final data = stack.pop();
    charCount += data.toString().length;
  }

  return charCount;
}

void main() {
  Stack<int> s1 = Stack<int>(4);
  Stack<String> s2 = Stack<String>();

  s1.push(55);
  s1.push(77);
  s1.pop();
  s1.push(99);
  s1.push(88);
  s1.push(11);

  s2.push('joao');
  s2.push('maria');
  s2.push('pedro');
  s2.pop();

  print(s1);
  print(s2);

  print(operation(s2));
}

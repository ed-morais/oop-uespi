class Elevator {
  final int _floorCount; // número de andares do prédio
  final int _capacity; // Capacidade do elevator
  int _persons = 0; // Quantidade de pessoas dentro do elevador
  int _floor = 0; // andar atual

  Elevator({
    required int floorCount,
    required int capacity,
  })  : _floorCount = floorCount,
        _capacity = capacity;

  @override
  String toString() {
    return 'Elevator(\n\tfloor: $_floor,\n\tpersons: $_persons,\n'
        '\tfloors: $_floorCount,\n\tcapacity: $_capacity\n)';
  }

  int get persons => _persons;
  int get floor => _floor;
  int get floors => _floorCount;
  int get capacity => _capacity;

  bool get isFull => _persons == _capacity;

  bool getIn([int quantity = 1]) {
    if (_persons + quantity > _capacity) {
      return false;
    }
    _persons += quantity;
    return true;
  }

  bool getOut([int quantity = 1]) {
    if (quantity > _persons) {
      return false;
    }
    _persons -= quantity;
    return true;
  }

  bool up([int levels = 1]) {
    if (_floor + levels >= _floorCount) {
      return false;
    }
    _floor += levels;
    return true;
  }

  bool down([int levels = 1]) {
    if (_floor - levels < 0) {
      return false;
    }
    _floor -= levels;
    return true;
  }
}

void main() {
  Elevator e1 = Elevator(floorCount: 5, capacity: 4);
  Elevator e2 = Elevator(floorCount: 10, capacity: 8);

  void showElevators() {
    print('e1: $e1');
    print('e2: $e2');
    print('-----------------------');
  }

  showElevators();
  if (!e1.getIn(12)) {
    print('Não cabem 12 pessoas');
  }
  e2.getIn(3);
  showElevators();

  print('e1 is Full? ${e1.isFull}');
}

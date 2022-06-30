import 'dart:mirrors';

class Product {
  final String name;
  final String description;

  const Product(this.name, this.description);
}

class Computer extends Product {
  final String processor;
  final String memory;

  Computer(name, description, this.processor, this.memory)
      : super(name, description);
}

void getDataMembers(ClassMirror classMirror) {
  for (var v in classMirror.declarations.values) {
    var name = MirrorSystem.getName(v.simpleName);

    if (v is VariableMirror) {
      print('Variable: $name');
      print('const: ${v.isConst}');
      print('final: ${v.isFinal}');
      print('private: ${v.isPrivate}');
      print('static: ${v.isStatic}');
      print('extension: ${v.isExtensionMember}');
    } else if (v is MethodMirror) {
      print('Method: $name');
      print('abstract: ${v.isAbstract}');
      print('private: ${v.isPrivate}');
      print('static: ${v.isStatic}');
      print('extension: ${v.isExtensionMember}');
      print('constructor: ${v.isConstructor}');
      print('top level: ${v.isTopLevel}');
    }

    print('-----------------------------');
  }
}

void main() {
  Computer computer =
      Computer('Computer One', 'No longer used', 'Dual-core', '1GB');
  InstanceMirror im = reflect(computer);
  ClassMirror classMirror = im.type;
  getDataMembers(classMirror);

  // Get data members of superclass
  ClassMirror? superClassMirror = classMirror.superclass;

  if (superClassMirror != null) {
    getDataMembers(superClassMirror);
  }
}

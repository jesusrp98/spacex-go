class Vehicle {
  final String id;
  final String name;
  final String type;
  final bool isActive;

  Vehicle(this.id, this.name, this.type, this.isActive);

  String get getType => '${type[0].toUpperCase()}${type.substring(1)}';

  String get getDescription =>
      getType + ' ' + ((isActive) ? 'currently' : 'not') + ' ' + 'active';
}

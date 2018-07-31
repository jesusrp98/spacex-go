class Vehicle {
  final String id;
  final String name;
  final String type;
  final bool isActive;

  Vehicle(this.id, this.name, this.type, this.isActive);

  String get getImageUrl {
    switch (id) {
      case 'falcon1':
        return 'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon1.jpg?alt=media&token=8015fe62-b2a5-418f-b37d-3641463f87c4';
      case 'falcon9':
        return 'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon9.jpg?alt=media&token=96b5c764-a2ea-43f0-8766-1761db1749d4';
      case 'falconheavy':
        return 'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falconheavy.jpg?alt=media&token=e9cdffae-fcdc-488c-9db5-587cc74e3255';
      case 'bfr':
        return 'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/bfr.jpg?alt=media&token=98b073e3-fec1-4b6f-a989-434eab88fd91';
      default:
        return 'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/rocket.png?alt=media&token=66f2dde6-e6ff-4f64-a4a4-9fab6dbe90c5';
    }
  }
}

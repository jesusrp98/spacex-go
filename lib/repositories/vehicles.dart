import '../models/index.dart';
import '../services/index.dart';
import 'index.dart';

/// Repository that holds a list of SpaceX vehicles.
class VehiclesRepository extends BaseRepository<VehiclesService> {
  List<Vehicle> _vehicles;
  List<String> _photos;

  VehiclesRepository(VehiclesService service) : super(service);

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final roadster = await service.getRoadster();
      final dragons = await service.getDragons();
      final rockets = await service.getRockets();
      final ships = await service.getShips();

      _vehicles = [
        RoadsterVehicle.fromJson(roadster.data),
        for (final item in dragons.data['docs']) DragonVehicle.fromJson(item),
        for (final item in rockets.data['docs']) RocketVehicle.fromJson(item),
        for (final item in ships.data['docs']) ShipVehicle.fromJson(item),
      ];

      if (photos == null) {
        final indices = List<int>.generate(7, (index) => index)
          ..shuffle()
          ..sublist(0, 5);

        _photos = [
          for (final index in indices) vehicles[index].getRandomPhoto,
        ];
        photos.shuffle();
      }
      finishLoading();
    } catch (_) {
      receivedError();
    }
  }

  List<String> get photos => _photos;

  List<Vehicle> get vehicles => _vehicles;

  int get getVehiclesCount => _vehicles.length;

  Vehicle getVehicleIndex(int index) => _vehicles[index];

  Vehicle getVehicle(String id) =>
      _vehicles.where((vehicle) => vehicle.id == id).first;

  String getVehicleType(String id) =>
      _vehicles.where((vehicle) => vehicle.id == id).first.type;
}

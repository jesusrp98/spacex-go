import '../models/index.dart';
import '../repositories-cubit/index.dart';
import 'base/index.dart';

/// Cubit that holds a list of SpaceX vehicles.
class VehiclesCubit extends RequestCubit<VehiclesRepository, List<Vehicle>> {
  VehiclesCubit(VehiclesRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading());

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }
}

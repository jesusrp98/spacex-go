import '../models/index.dart';
import '../repositories/index.dart';
import 'base/index.dart';

class VehiclesCubit extends RequestCubit<VehiclesRepository, List<Vehicle>> {
  VehiclesCubit(VehiclesRepository service) : super(service);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading());

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}

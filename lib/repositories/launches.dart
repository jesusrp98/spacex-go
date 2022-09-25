import 'package:cherry/utils/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../models/index.dart';
import '../services/index.dart';

/// Handles retrieve and transformation of [Launch] from the API, both past & future ones.
class LaunchesRepository
    extends RequestRepository<LaunchesService, List<List<Launch>>> {
  LaunchesRepository(LaunchesService service) : super(service);

  @override
  Future<List<List<Launch>>> fetchData() async {
    final response = await service.getLaunches();
    final launches = [
      for (final item in response.data['docs']) Launch.fromJson(item)
    ]..sort();

    return [
      launches.where((l) => l.upcoming).toList(),
      launches.where((l) => !l.upcoming).toList().reversed.toList()
    ];
  }

  Launch? getLaunch(String id) {
    if (state.status == RequestStatus.loaded) {
      return LaunchUtils.getAllLaunches(state.value!)
          ?.where((l) => l.id == id)
          .single;
    } else {
      return null;
    }
  }
}

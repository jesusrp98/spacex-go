import '../services/index.dart';

/// Agent that handles the structure process of raw data, coming from a [Service]
/// agent.
///
/// Parameters:
/// - S: service that extends [BaseService].
/// - T: model with which structure the raw data.
abstract class BaseRepository<S extends BaseService, T> {
  /// Agent that handles retrieve of pure raw information from the API or Firebase...
  final S service;

  const BaseRepository(this.service) : assert(service != null);

  /// Calls the [service] internal
  Future<T> fetchData();
}

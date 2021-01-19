import '../services/index.dart';

abstract class BaseRepository<S extends BaseService, T> {
  final S service;

  const BaseRepository(this.service) : assert(service != null);

  Future<T> fetchData();
}

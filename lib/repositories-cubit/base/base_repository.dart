abstract class BaseRepository<S, T> {
  final S client;

  const BaseRepository(this.client) : assert(client != null);

  Future<T> fetchData();
}

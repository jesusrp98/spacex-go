/// This class serves as a base for building API clients.
abstract class BaseService<S> {
  final S client;

  const BaseService(this.client) : assert(client != null);
}

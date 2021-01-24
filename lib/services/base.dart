/// This class serves as a base for building API clients.
///
/// [S] can be anything you want! It's the base agent to make the connection
/// with the data.
/// - For **http** connections, we usually use [Dio].
/// - For **Firebase** use the proper Firebase instance.
abstract class BaseService<S> {
  /// Class that actually makes the connection to the data service
  final S client;

  const BaseService(this.client) : assert(client != null);
}

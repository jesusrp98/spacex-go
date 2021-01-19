import 'package:dio/dio.dart';

/// This class serves as a base for building API clients.
/// It uses a simple [DIO] client as the main HTTP client.
abstract class BaseService {
  final Dio client;

  const BaseService(this.client) : assert(client != null);
}

import 'package:dio/dio.dart';

/// TODO
abstract class BaseService {
  final Dio client;

  const BaseService(this.client) : assert(client != null);
}

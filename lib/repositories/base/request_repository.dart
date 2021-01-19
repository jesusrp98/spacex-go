import 'package:dio/dio.dart';

import 'index.dart';

abstract class RequestRepository<T> extends BaseRepository<Dio, T> {
  const RequestRepository(Dio client) : super(client);
}

import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import '../utils/index.dart';

/// Services that retrieves information about the company itself.
class CompanyService extends BaseService<Dio> {
  const CompanyService(Dio client) : super(client);

  Future<Response> getCompanyInformation() async {
    return client.get(Url.companyInformation);
  }
}

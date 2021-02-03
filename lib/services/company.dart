import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves information about the company itself.
class CompanyService extends BaseService<Dio> {
  const CompanyService(Dio client) : super(client);

  Future<Response> getCompanyInformation() async {
    return client.get(Url.companyInformation);
  }
}

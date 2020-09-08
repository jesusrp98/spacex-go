import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// TODO
class CompanyService extends BaseService {
  const CompanyService(Dio client) : super(client);

  /// Retrieves a list featuring the latest SpaceX acomplishments.
  Future<Response<List>> getAchievements() async {
    return client.get(Url.companychievements);
  }

  /// Retrieves general information about SpaceX.
  Future<Response> getCompanyInformation() async {
    return client.get(Url.companyInformation);
  }
}

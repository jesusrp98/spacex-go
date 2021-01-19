import 'package:dio/dio.dart';

import '../util/index.dart';
import 'index.dart';

/// Services that retrieves information about the company itself.
class CompanyService extends BaseService {
  const CompanyService(Dio client) : super(client);

  /// Retrieves a list featuring the latest SpaceX acomplishments.
  Future<Response> getAchievements() async {
    return client.get(Url.companyAchievements);
  }

  /// Retrieves general information about SpaceX.
  Future<Response> getCompanyInformation() async {
    return client.get(Url.companyInformation);
  }
}

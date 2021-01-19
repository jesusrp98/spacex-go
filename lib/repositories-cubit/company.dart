import 'package:dio/dio.dart';

import '../models/index.dart';
import '../util/index.dart';
import 'base/index.dart';

class CompanyRepository extends RequestRepository<CompanyInfo> {
  const CompanyRepository(Dio client) : super(client);

  @override
  Future<CompanyInfo> fetchData() async {
    final response = await client.get(Url.companyInformation);
    return CompanyInfo.fromJson(response.data);
  }
}

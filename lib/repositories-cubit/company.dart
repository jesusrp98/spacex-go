import '../models/index.dart';
import '../services/index.dart';
import 'index.dart';

/// Handles retrieve and transformation of [ComapnyInfo] from the API.
class CompanyRepository extends BaseRepository<CompanyService, CompanyInfo> {
  const CompanyRepository(CompanyService service) : super(service);

  @override
  Future<CompanyInfo> fetchData() async {
    final response = await service.getCompanyInformation();

    return CompanyInfo.fromJson(response.data);
  }
}

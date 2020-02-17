import 'package:dio/dio.dart';

import '../models/index.dart';
import '../services/api_service.dart';
import 'index.dart';

/// Repository that holds information about SpaceX.
class CompanyRepository extends BaseRepository {
  List<Achievement> achievements;
  Company company;

  @override
  Future<void> loadData() async {
    // Try to load the data using [ApiService]
    try {
      // Receives the data and parse it
      final Response<List> achievementsResponse =
          await ApiService.getAchievements();
      final Response companyResponse = await ApiService.getCompanyInformation();

      achievements = [
        for (final item in achievementsResponse.data) Achievement.fromJson(item)
      ];
      company = Company.fromJson(companyResponse.data);

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';
import '../services/api_service.dart';
import '../util/photos.dart';
import 'index.dart';

/// Repository that holds information about SpaceX.
class CompanyRepository extends BaseRepository {
  List<Achievement> achievements;
  List<String> photos;
  Company company;

  @override
  Future<void> loadData([BuildContext context]) async {
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

      photos ??= List.from(SpaceXPhotos.company);
      photos.shuffle();

      finishLoading();
    } catch (_) {
      receivedError();
    }
  }
}

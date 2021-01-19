// import '../models/index.dart';
// import '../services/index.dart';
// import 'index.dart';

// /// Repository that holds information about SpaceX.
// class CompanyRepository extends BaseRepository<CompanyService> {
//   List<Achievement> _achievements;
//   CompanyInfo _companyInfo;

//   CompanyRepository(CompanyService service) : super(service);

//   @override
//   Future<void> loadData() async {
//     // Try to load the data using [ApiService]
//     try {
//       // Receives the data and parse it
//       final achievementsResponse = await service.getAchievements();
//       final companyResponse = await service.getCompanyInformation();

//       _achievements = [
//         for (final item in achievementsResponse.data) Achievement.fromJson(item)
//       ];
//       _companyInfo = CompanyInfo.fromJson(companyResponse.data);

//       finishLoading();
//     } catch (e) {
//       receivedError(e);
//     }
//   }

//   Achievement getAchievement(int index) => _achievements[index];

//   int get getAchievementsCount => _achievements?.length;

//   CompanyInfo get company => _companyInfo;
// }

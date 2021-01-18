import '../models/index.dart';
import '../services/index.dart';
import 'base/index.dart';

class CompanyCubit extends RequestCubit<CompanyService, CompanyInfo> {
  CompanyCubit(CompanyService service) : super(service);

  @override
  Future<void> fetchData() async {
    emit(RequestState.loading());

    try {
      final response = await service.getCompanyInformation();
      final data = CompanyInfo.fromJson(response.data);

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}

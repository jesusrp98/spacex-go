import '../models/index.dart';
import '../repositories-cubit/index.dart';
import 'base/index.dart';

class CompanyCubit
    extends RequestPersistantCubit<CompanyRepository, CompanyInfo> {
  CompanyCubit(CompanyRepository service) : super(service);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading());

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e));
    }
  }
}

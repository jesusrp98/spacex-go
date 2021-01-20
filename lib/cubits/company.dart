import '../models/index.dart';
import '../repositories-cubit/index.dart';
import 'base/index.dart';

class CompanyCubit extends RequestCubit<CompanyRepository, CompanyInfo> {
  CompanyCubit(CompanyRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading());

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }
}

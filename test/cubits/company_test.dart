import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:cherry/cubits/index.dart';
import 'package:cherry/models/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  group('CompanyCubit', () {
    CompanyCubit cubit;
    MockCompanyRepository repository;

    setUp(() {
      repository = MockCompanyRepository();
      cubit = CompanyCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    group('fetchData', () {
      blocTest<CompanyCubit, RequestState>(
        'fetches data correctly',
        build: () {
          when(repository.fetchData()).thenAnswer(
            (_) => Future.value(CompanyInfo(id: '1')),
          );
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: () => [
          RequestState<CompanyInfo>.loading(),
          RequestState<CompanyInfo>.loaded(CompanyInfo(id: '1')),
        ],
      );

      blocTest<CompanyCubit, RequestState>(
        'can throw an exception',
        build: () {
          when(repository.fetchData()).thenThrow(Exception('wtf'));
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: () => [
          RequestState<CompanyInfo>.loading(),
          RequestState<CompanyInfo>.error(Exception('wtf').toString()),
        ],
      );
    });
  });
}

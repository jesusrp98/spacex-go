import 'package:bloc/bloc.dart';
import 'package:cherry/utils/index.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockBloc extends Mock implements Bloc<Object, int> {}

// ignore: must_be_immutable, avoid_implementing_value_types
class MockTransition extends Mock implements Transition<Object, int> {}

void main() {
  group('BlocObserver', () {
    group('onCreate', () {
      test('does nothing by default', () {
        // ignore: invalid_use_of_protected_member
        CherryBlocObserver().onCreate(MockBloc());
      });
    });

    group('onEvent', () {
      test('does nothing by default', () {
        // ignore: invalid_use_of_protected_member
        CherryBlocObserver().onEvent(MockBloc(), Object());
      });
    });

    group('onChange', () {
      test('does nothing by default', () {
        // ignore: invalid_use_of_protected_member
        CherryBlocObserver().onChange(MockBloc(), MockTransition());
      });
    });

    group('onTransition', () {
      test('does nothing by default', () {
        // ignore: invalid_use_of_protected_member
        CherryBlocObserver().onTransition(MockBloc(), MockTransition());
      });
    });

    group('onError', () {
      test('does nothing by default', () {
        // ignore: invalid_use_of_protected_member
        CherryBlocObserver().onError(MockBloc(), Object(), StackTrace.current);
      });
    });

    group('onClose', () {
      test('does nothing by default', () {
        // ignore: invalid_use_of_protected_member
        CherryBlocObserver().onClose(MockBloc());
      });
    });
  });
}

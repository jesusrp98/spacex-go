import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/index.dart';
import 'index.dart';

abstract class RequestCubit<R extends BaseRepository>
    extends Cubit<RequestState> {
  final R repository;

  RequestCubit(this.repository) : super(RequestState.init());

  Future<void> loadData();
}

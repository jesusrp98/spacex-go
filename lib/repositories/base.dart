import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Status { loading, error, loaded }

abstract class BaseRepository with ChangeNotifier {
  // Status regarding data loading capabilities
  Status _status;

  BaseRepository([BuildContext context]) {
    startLoading();
    loadData(context);
  }

  // Overridable method, used to load the model's data
  Future<void> loadData([BuildContext context]);

  // Reloads model's data
  Future refreshData() => loadData();

  // Status getters
  bool get isLoading => _status == Status.loading;
  bool get loadingFailed => _status == Status.error;
  bool get isLoaded => _status == Status.loaded;

  // Methods which update the [_status] variable
  void startLoading() {
    _status = Status.loading;
  }

  void finishLoading() {
    _status = Status.loaded;
    notifyListeners();
  }

  void receivedError() {
    _status = Status.error;
    notifyListeners();
  }
}

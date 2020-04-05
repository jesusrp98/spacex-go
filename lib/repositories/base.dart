import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Status { loading, error, loaded }

/// This class serves as the building blocks of a repository.
///
/// A repository has the purpose to load and parse the data
/// received from the [ApiService] class.
abstract class BaseRepository with ChangeNotifier {
  final BuildContext context;

  /// Status regarding data loading capabilities
  Status _status;

  BaseRepository([this.context]) {
    startLoading();
    loadData();
  }

  /// Overridable method, used to load the model's data.
  Future<void> loadData();

  /// Reloads model's data, calling [loadData] once again.
  Future<void> refreshData() => loadData();

  bool get isLoading => _status == Status.loading;
  bool get loadingFailed => _status == Status.error;
  bool get isLoaded => _status == Status.loaded;

  /// Signals that information is being donwloaded.
  void startLoading() {
    _status = Status.loading;
  }

  /// Signals that information has been donwloaded.
  void finishLoading() {
    _status = Status.loaded;
    notifyListeners();
  }

  /// Signals that there has been an error downloading data.
  void receivedError() {
    _status = Status.error;
    notifyListeners();
  }
}

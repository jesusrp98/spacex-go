import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// General model used to help retrieve, parse & storage
/// information from a public REST API
enum Status { loading, error, loaded }

abstract class QueryModel with ChangeNotifier {
  // Lists of both models info & its photos
  final List items, photos;

  // Model's status regarding data loading capabilities
  Status _status = Status.loading;

  QueryModel([BuildContext context])
      : _status = Status.loading,
        items = List(),
        photos = List() {
    loadData(context);
  }

  // Fetches data & returns it
  Future fetchData(String url, {Map<String, dynamic> parameters}) async {
    final response = await Dio().get(url, queryParameters: parameters);
    if (items.isNotEmpty) items.clear();

    return response.data;
  }

  // Overridable method, used to load the model's data
  Future loadData([BuildContext context]);

  // Reloads model's data
  Future refreshData() async => await loadData();

  // General getters for both lists
  dynamic getItem(index) => items[index];
  String getPhoto(index) => photos[index];

  int get getItemCount => items.length;
  int get getPhotosCount => photos.length;

  // Status getters
  bool get isLoading => _status == Status.loading;
  bool get loadingFailed => _status == Status.error;

  // Methods which update the [_status] variable
  void finishLoading() {
    _status = Status.loaded;
    notifyListeners();
  }

  void receivedError() {
    _status = Status.error;
    notifyListeners();
  }

  // Checks internet connection & sets [_status] variable
  Future<bool> connectionFailure() async {
    _status =
        await Connectivity().checkConnectivity() == ConnectivityResult.none
            ? Status.error
            : Status.loading;
    return !isLoading;
  }
}

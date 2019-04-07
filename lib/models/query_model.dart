import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

/// QUERY MODEL
/// General model used to help retrieve, parse & storage
/// information from a public API
abstract class QueryModel extends Model {
  List _items = List();
  List _photos = List();

  bool _loading = true;

  // Updated the 'loading' state
  setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  // Retrieves fetched data
  Future fetchData(String url, {Map<String, dynamic> parameters}) async {
    final response = await Dio().get(url, queryParameters: parameters);

    return response.data;
  }

  // Reloads the info loading data once again
  Future refresh() async => await loadData();

  // To-be-implemented method, which loads the model's data
  Future loadData([BuildContext context]);

  // General getters
  List get items => _items;

  List get photos => _photos;

  dynamic getItem(index) => _items[index];

  String getPhoto(index) => _photos[index];

  int get getItemCount => _items.length;

  int get getPhotosCount => _photos.length;

  bool get isLoading => _loading;

  clearItems() => _items.clear();
}

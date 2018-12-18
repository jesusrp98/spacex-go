import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

/// QUERRY MODEL
/// General model used to help retrieve, parse & storage
/// information from a public API
abstract class QuerryModel extends Model {
  List _items = List();
  List _photos = List();

  List snapshot;
  var response;

  bool _loading = true;

  Future refresh() async {
    clearItems();
    await loadData();
    notifyListeners();
  }

  void setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  Future loadData();

  List get items => _items;

  List get photos => _photos;

  dynamic getItem(index) => _items[index];

  String getPhoto(index) => _photos[index];

  int get getItemCount => _items.length;

  int get getPhotosCount => _photos.length;

  bool get isLoading => _loading;

  clearItems() => _items.clear();
}

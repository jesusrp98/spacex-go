import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';

/// QUERY MODEL
/// General model used to help retrieve, parse & storage
/// information from a public API
abstract class QueryModel extends Model {
  List _items = List();
  List _photos = List();

  bool _loading = true;

  setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  Future fetchData(String url) async {
    final response = await Dio().get(url);

    return response.data;
  }

  Future refresh() async => await loadData();

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

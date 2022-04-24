import 'package:flutter/material.dart';
import 'package:products/model/product_data_model.dart';
import 'package:products/utils/enum.dart';

class Products with ChangeNotifier {
  final List<ProductDataModel> _products = [
    ProductDataModel(
        id: DateTime(2022, 08, 8).microsecondsSinceEpoch.toString(),
        name: "A",
        launchedDate: DateTime(2022, 08, 8),
        launchSite: "Z",
        popularity: 4),
    ProductDataModel(
        id: DateTime(2022, 08, 6).microsecondsSinceEpoch.toString(),
        name: "B",
        launchedDate: DateTime(2022, 08, 6),
        launchSite: "Y",
        popularity: 5),
    ProductDataModel(
        id: DateTime(2022, 08, 7).microsecondsSinceEpoch.toString(),
        name: "C",
        launchedDate: DateTime(2022, 08, 7),
        launchSite: "X",
        popularity: 2),
  ];

  List<ProductDataModel> get products => _products;

  bool isNameAscending = true;
  bool isDateAscending = true;
  bool isLaunchAscending = true;
  bool isPopularityAscending = true;

  sortList(SortType shortType) {
    if (shortType == SortType.name) {
      if (isNameAscending == false) {
        _products.sort((a, b) => b.name.compareTo(a.name));
        isNameAscending = true;
      } else {
        _products.sort((a, b) => a.name.compareTo(b.name));
        isNameAscending = false;
      }
    } else if (shortType == SortType.date) {
      if (isDateAscending == false) {
        _products.sort((a, b) => b.launchedDate.compareTo(a.launchedDate));
        isDateAscending = true;
      } else {
        _products.sort((a, b) => a.launchedDate.compareTo(b.launchedDate));
        isDateAscending = false;
      }
    } else if (shortType == SortType.launch) {
      if (isLaunchAscending == false) {
        _products.sort((a, b) => b.launchSite.compareTo(a.launchSite));
        isLaunchAscending = true;
      } else {
        _products.sort((a, b) => a.launchSite.compareTo(b.launchSite));
        isLaunchAscending = false;
      }
    } else if (shortType == SortType.popularity) {
      if (isPopularityAscending == false) {
        _products.sort((a, b) => b.popularity.compareTo(a.popularity));
        isPopularityAscending = true;
      } else {
        _products.sort((a, b) => a.popularity.compareTo(b.popularity));
        isPopularityAscending = false;
      }
    }
    notifyListeners();
  }

  addProduct(ProductDataModel item) {
    _products.add(item);
    notifyListeners();
  }

  deleteProduct(ProductDataModel item) {
    _products.remove(item);
    notifyListeners();
  }

  editProduct(ProductDataModel item) {
    int index = _products.indexWhere((element) => element.id == item.id);
    _products[index].name = item.name;
    _products[index].launchSite = item.launchSite;
    _products[index].launchedDate = item.launchedDate;
    _products[index].popularity = item.popularity;
    notifyListeners();
  }
}

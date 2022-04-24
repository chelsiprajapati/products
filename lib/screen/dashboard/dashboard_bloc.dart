import 'package:flutter/material.dart';
import 'package:products/model/product_data_model.dart';
import 'package:products/provider/product_provider.dart';
import 'package:products/utils/enum.dart';
import 'package:provider/provider.dart';

class DashboardBloc {
  static DashboardBloc? _bloc;

  static DashboardBloc getInstance() {
    return _bloc ?? DashboardBloc();
  }

  static DashboardBloc newInstance() {
    return DashboardBloc();
  }

  List<ProductDataModel> getFilteredList(BuildContext context) {
    final _list = context.select((List<ProductDataModel> list) => list);
    return _list;
  }

  bool isListView = true;

  List _products = [];
  bool _isNameAscending = false;
  bool _isDateAscending = false;
  bool _isLaunchAscending = false;
  bool _isPopularityAscending = false;
  List get products => _products;
  bool get isNameAscending => _isNameAscending;
  bool get isDateAscending => _isDateAscending;
  bool get isLaunchAscending => _isLaunchAscending;
  bool get isPopularityAscending => _isPopularityAscending;
  SortType? selectedSortType;

  void initData(context) {
    _products = Provider.of<Products>(context, listen: true).products;
    _isNameAscending =
        Provider.of<Products>(context, listen: true).isNameAscending;
    _isDateAscending =
        Provider.of<Products>(context, listen: true).isDateAscending;
    _isLaunchAscending =
        Provider.of<Products>(context, listen: true).isLaunchAscending;
    _isPopularityAscending =
        Provider.of<Products>(context, listen: true).isPopularityAscending;
  }

  void sortList(SortType shortType, BuildContext context) {
    selectedSortType = shortType;
    Provider.of<Products>(context, listen: false).sortList(shortType);
  }

  void delete(ProductDataModel productDataModel, BuildContext context) {
    Provider.of<Products>(context, listen: false)
        .deleteProduct(productDataModel);
  }
}

import 'package:flutter/material.dart';
import 'package:products/screen/add_edit_products/add_edit_product_screen.dart';
import 'package:products/screen/dashboard/dashboard_screen.dart';

class RouteName {
  static const String dashboard = '/';
  static const String addEditProduct = '/addEditProduct';
}

class Routes {
  static final baseRoutes = <String, WidgetBuilder>{
    RouteName.dashboard: (context) => const Dashboard(),
    RouteName.addEditProduct: (context) => const AddEditProduct(),
  };
}

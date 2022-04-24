import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:products/model/product_data_model.dart';
import 'package:products/model/route_data.dart';
import 'package:products/provider/product_provider.dart';
import 'package:products/utils/date_format_utils.dart';
import 'package:products/utils/string_utils.dart';
import 'package:provider/provider.dart';

class AddEditProductBloc {
  static AddEditProductBloc? _bloc;

  GlobalKey<FormState> formKey = GlobalKey();

  static AddEditProductBloc getInstance() {
    return _bloc ?? AddEditProductBloc();
  }

  static AddEditProductBloc newInstance() {
    return AddEditProductBloc();
  }

  StreamController<bool> mainStreamController = StreamController.broadcast();
  Stream<bool> get mainStream => mainStreamController.stream;

  StreamController<DateTime> dateStreamController =
      StreamController.broadcast();
  Stream<DateTime> get dateStream => dateStreamController.stream;

  ProductDataModel? _productDataModel;

  bool isUpdate = false;
  bool isProtected = false;

  ProductDataModel? get productDataModel => _productDataModel;

  void initializeData(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      RouteDataArgument? _arguments =
          ModalRoute.of(context)!.settings.arguments as RouteDataArgument;
      if (_arguments.data != null) {
        print(_arguments.data);
        int? index = _arguments.data['index'];
        if (index != null) {
          ProductDataModel productDataModel =
              Provider.of<Products>(context, listen: false).products[index];
          id = productDataModel.id;
          nameController.text = productDataModel.name;
          popularity = productDataModel.popularity;
          dateController.text =
              DateFormatUtils.formattedDate(productDataModel.launchedDate);
          selectedDate = productDataModel.launchedDate;
          siteController.text = productDataModel.launchSite;
          isUpdate = true;
          mainStreamController.sink.add(true);
        } else {
          isUpdate = false;
          mainStreamController.sink.add(true);
        }
      }
    } else {
      isProtected = true;
      mainStreamController.sink.add(true);
      showDialogBox(context);
    }
  }

  void showDialogBox(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (con) => CupertinoAlertDialog(
              title: const Text(StringUtils.alert),
              content: const Text(StringUtils.messageYouCanNotAccess),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text(StringUtils.ok),
                  onPressed: () {
                    Navigator.pop(con);
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  String id = "";
  double popularity = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColor // body text color
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormatUtils.formattedDate(selectedDate);
      dateStreamController.sink.add(selectedDate);
    }
  }

  void addUpdateData(BuildContext context, {required bool isUpdate}) {
    if (formKey.currentState!.validate()) {
      if (popularity == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please add popularity")));
      } else {
        if (isUpdate) {
          Provider.of<Products>(context, listen: false).editProduct(
              ProductDataModel(
                  id: id,
                  name: nameController.text,
                  launchedDate: DateFormatUtils.getDate(dateController.text),
                  launchSite: siteController.text,
                  popularity: popularity));
        } else {
          Provider.of<Products>(context, listen: false).addProduct(
              ProductDataModel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: nameController.text,
                  launchedDate: DateFormatUtils.getDate(dateController.text),
                  launchSite: siteController.text,
                  popularity: popularity));
        }

        Navigator.pop(context);
      }
    }
  }

  nameValidation(value) {
    if (value == null || value.isEmpty) {
      return StringUtils.enterName;
    }
    return null;
  }

  dateValidation(value) {
    if (value == null || value.isEmpty) {
      return StringUtils.selectDate;
    }
    return null;
  }

  launchValidation(value) {
    if (value == null || value.isEmpty) {
      return StringUtils.enterLaunchSite;
    }
    return null;
  }
}

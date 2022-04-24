import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:products/model/product_data_model.dart';
import 'package:products/model/route_data.dart';
import 'package:products/provider/product_provider.dart';
import 'package:products/screen/add_edit_products/add_edit_product_bloc.dart';
import 'package:products/utils/string_utils.dart';
import 'package:products/utils/theme_utils.dart';
import 'package:provider/provider.dart';

class AddEditProduct extends StatefulWidget {
  const AddEditProduct({Key? key}) : super(key: key);

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final AddEditProductBloc _addEditProductBloc =
      AddEditProductBloc.getInstance();

  final AppTheme _appTheme = AppTheme();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _addEditProductBloc.initializeData(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_addEditProductBloc.isUpdate
            ? StringUtils.editProduct
            : StringUtils.addProduct),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<bool>(
            stream: _addEditProductBloc.mainStream,
            builder: (context, snapshot) {
              return _addEditProductBloc.isProtected
                  ? Container()
                  : Column(
                      children: [
                        Form(
                          key: _addEditProductBloc.formKey,
                          child: Container(
                            margin: _appTheme.outerPadding,
                            padding: _appTheme.innerPadding,
                            decoration: _appTheme.cardDecoration,
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) =>
                                      _addEditProductBloc.nameValidation(value),
                                  controller:
                                      _addEditProductBloc.nameController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      floatingLabelStyle: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      contentPadding: const EdgeInsets.all(0),
                                      labelText: StringUtils.enterName),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () {
                                    _addEditProductBloc.selectDate(context);
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      validator: (value) => _addEditProductBloc
                                          .dateValidation(value),
                                      controller:
                                          _addEditProductBloc.dateController,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          labelText: StringUtils.selectDate),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) => _addEditProductBloc
                                      .launchValidation(value),
                                  controller:
                                      _addEditProductBloc.siteController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      contentPadding: const EdgeInsets.all(0),
                                      labelText: StringUtils.enterLaunchSite),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  child: RatingBar.builder(
                                    itemSize: 32,
                                    ignoreGestures: false,
                                    initialRating:
                                        _addEditProductBloc.popularity,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    onRatingUpdate: (rating) {
                                      _addEditProductBloc.popularity = rating;
                                      print(rating);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                  primary: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                          color: Colors.transparent))),
                              onPressed: () {
                                _addEditProductBloc.addUpdateData(context,
                                    isUpdate: _addEditProductBloc.isUpdate);
                              },
                              child: const Text(StringUtils.submit)),
                        )
                      ],
                    );
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:products/model/product_data_model.dart';
import 'package:products/model/route_data.dart';
import 'package:products/utils/call_backs.dart';
import 'package:products/utils/date_format_utils.dart';
import 'package:products/utils/routes.dart';
import 'package:products/utils/string_utils.dart';
import 'package:products/utils/theme_utils.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback editCallBack;
  final VoidCallback deleteCallBack;
  final ProductDataModel productDataModel;
  const ProductCard(
      {Key? key,
      required this.productDataModel,
      required this.editCallBack,
      required this.deleteCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme _appTheme = AppTheme();

    Widget getLabelColumn(String label, String text) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
          Text(text)
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: _appTheme.innerPadding,
      decoration: _appTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getLabelColumn(StringUtils.name, productDataModel.name),
              Row(
                children: [
                  InkWell(
                    onTap: editCallBack,
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: deleteCallBack,
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ],
          ),
          getLabelColumn(StringUtils.launchSite, productDataModel.launchSite),
          getLabelColumn(StringUtils.launchDate,
              DateFormatUtils.formattedDate(productDataModel.launchedDate)),
          Text(
            StringUtils.ratings,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
          RatingBar.builder(
            itemSize: 24,
            ignoreGestures: true,
            initialRating: productDataModel.popularity,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
              size: 18,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          )
        ],
      ),
    );
  }
}

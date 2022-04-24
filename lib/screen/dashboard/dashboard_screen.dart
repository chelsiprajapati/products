import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:products/model/product_data_model.dart';
import 'package:products/model/route_data.dart';
import 'package:products/screen/dashboard/dashboard_bloc.dart';
import 'package:products/screen/widget/product_card.dart';
import 'package:products/utils/enum.dart';
import 'package:products/utils/image_utils.dart';
import 'package:products/utils/routes.dart';
import 'package:products/utils/string_utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../provider/product_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardBloc _bloc = DashboardBloc.getInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.initData(context);
    Widget getIconText(
        {required String icon,
        required String text,
        required bool isSelected,
        required VoidCallback callback}) {
      return InkWell(
          onTap: callback,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.white),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  height: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringUtils.dashboard),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 132,
            child: ResponsiveGridList(
              horizontalGridMargin: 16,
              verticalGridMargin: 16,
              minItemWidth: 120,
              children: [
                getIconText(
                    callback: () {
                      _bloc.sortList(SortType.name, context);
                    },
                    icon: _bloc.isNameAscending
                        ? SvgUtils.upArrow
                        : SvgUtils.downArrow,
                    text: "Name",
                    isSelected: _bloc.selectedSortType == SortType.name),
                getIconText(
                    callback: () {
                      _bloc.sortList(SortType.launch, context);
                    },
                    icon: _bloc.isLaunchAscending
                        ? SvgUtils.upArrow
                        : SvgUtils.downArrow,
                    text: "Launch Site",
                    isSelected: _bloc.selectedSortType == SortType.launch),
                getIconText(
                    callback: () {
                      _bloc.sortList(SortType.date, context);
                    },
                    icon: _bloc.isDateAscending
                        ? SvgUtils.upArrow
                        : SvgUtils.downArrow,
                    text: "Date",
                    isSelected: _bloc.selectedSortType == SortType.date),
                getIconText(
                    callback: () {
                      _bloc.sortList(SortType.popularity, context);
                    },
                    icon: _bloc.isPopularityAscending
                        ? SvgUtils.upArrow
                        : SvgUtils.downArrow,
                    text: "Popularity",
                    isSelected: _bloc.selectedSortType == SortType.popularity),
                if (kIsWeb)
                  getIconText(
                      callback: () {
                        setState(() {
                          _bloc.isListView = false;
                        });
                      },
                      icon: SvgUtils.grid,
                      text: "Grid View",
                      isSelected: !_bloc.isListView),
                if (kIsWeb)
                  getIconText(
                      callback: () {
                        setState(() {
                          _bloc.isListView = true;
                        });
                      },
                      icon: SvgUtils.list,
                      text: "List View",
                      isSelected: _bloc.isListView),
              ],
            ),
          ),
          Expanded(
            child: _bloc.isListView
                ? ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    itemCount: _bloc.products.length,
                    itemBuilder: (_, index) => ChangeNotifierProvider<Products>(
                      create: (BuildContext context) {
                        return Products();
                      },
                      child: ProductCard(
                        deleteCallBack: () {
                          _bloc.delete(_bloc.products[index], context);
                        },
                        editCallBack: () {
                          Navigator.pushNamed(context, RouteName.addEditProduct,
                              arguments:
                                  RouteDataArgument(data: {"index": index}));
                        },
                        productDataModel: _bloc.products[index],
                      ),
                    ),
                  )
                : ResponsiveGridList(
                    horizontalGridMargin: 16,
                    verticalGridMargin: 16,
                    minItemWidth: 240,
                    children: List.generate(
                      _bloc.products.length,
                      (index) => ChangeNotifierProvider<Products>(
                        create: (BuildContext context) => Products(),
                        child: ProductCard(
                          deleteCallBack: () {
                            _bloc.delete(_bloc.products[index], context);
                          },
                          editCallBack: () {
                            Navigator.pushNamed(
                                context, RouteName.addEditProduct,
                                arguments:
                                    RouteDataArgument(data: {"index": index}));
                          },
                          productDataModel: _bloc.products[index],
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, RouteName.addEditProduct,
              arguments: RouteDataArgument(data: {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

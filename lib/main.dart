import 'package:flutter/material.dart';
import 'package:products/provider/product_provider.dart';
import 'package:products/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Products(),
          ),
        ],
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Products',
            theme: ThemeData(
                appBarTheme: const AppBarTheme(color: Color(0xff230470)),
                //primarySwatch: MaterialColor(0xff230470, []),
                primaryColor: const Color(0xff230470)),
            routes: Routes.baseRoutes,
            initialRoute: RouteName.dashboard,
          );
        });
  }
}

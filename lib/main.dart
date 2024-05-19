import 'package:f05_eshop/model/cart.store.dart';
import 'package:f05_eshop/pages/cart.dart';
import 'package:f05_eshop/pages/product_detail_page.dart';
import 'package:f05_eshop/pages/product_form_page.dart';
import 'package:f05_eshop/pages/products.dart';
import 'package:f05_eshop/pages/products_overview_page.dart';
import 'package:f05_eshop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CartModelX>(create: (context) => CartModelX()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ProductList(),
        child: MaterialApp(
            title: 'Minha Loja',
            theme: ThemeData(
                fontFamily: 'Lato',
                //primarySwatch: Colors.pink,
                colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                    primary: Colors.pink, secondary: Colors.orangeAccent)),
            home: ProductsOverviewPage(),
            routes: {
              AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
              AppRoutes.PRODUCT_FORM: (context) => ProductFormPage(),
              AppRoutes.CART: (context) => Cart(),
              AppRoutes.PRODUCTS: (context) => Products()
              //AppRoutes.PRODUCTS: (context) => Product_Management();
            },
            debugShowCheckedModeBanner: false),
      ),
    );
  }
}

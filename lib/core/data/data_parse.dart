import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/favorites/fave_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataParse {
  Future<List<dynamic>> getFavProductList() async {
    final preferences = await SharedPreferences.getInstance();
    var favList = <String>[];

    final currentType = preferences.getString('POCKET_GUIDE_INDUSTRY_TYPE');
    final faveListStoreKey = await FaveSharedPreferences.getFaveListStoreKey();
    if (preferences.getStringList(faveListStoreKey) != null) {
      favList = preferences.getStringList(faveListStoreKey)!;
    }

    final Box<dynamic> productBox;
    if (currentType == 'INDUSTRY') {
      productBox = Hive.box('industryProductBox');
    } else {
      productBox = Hive.box('hcProductBox');
    }
    final productList = <dynamic>[];
    for (final prd in favList) {
      if (productBox.get(int.parse(prd)) != null) {
        productList.add(productBox.get(int.parse(prd)));
      }
    }
    return productList;
  }

  List<dynamic> searchProductByPrdOrName(
    String searched,
    String layout,
  ) {
    final Box<dynamic> productBox;
    final searchedProducts = <dynamic>[];

    if (layout.contains('hc')) {
      productBox = Hive.box('hcProductBox');
      final searchedResult = productBox.values.where(
        (element) =>
            (element as Map)['prd']
                .toString()
                .toLowerCase()
                .contains(searched) ||
            element['product_name'].toString().toLowerCase().contains(searched),
      );
      searchedProducts.addAll(searchedResult);
    } else {
      productBox = Hive.box('industryProductBox');
      final searchedResult = productBox.values.where(
        (element) =>
            (element as Map)['prd']
                .toString()
                .toLowerCase()
                .contains(searched) ||
            element['product_name'].toString().toLowerCase().contains(searched),
      );
      searchedProducts.addAll(searchedResult);
    }
    return searchedProducts;
  }
}

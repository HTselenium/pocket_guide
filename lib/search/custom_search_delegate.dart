import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/data/data_injection.dart';
import 'package:pocket_guide/core/data/data_parse.dart';
import 'package:pocket_guide/core/router/routes_enum.dart';
import 'package:pocket_guide/core/widgets/custom_list_widget.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/models/products_category_enum.dart';
import 'package:pocket_guide/search/search_empty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSearchDelegate extends SearchDelegate<dynamic> {
  // Demo list to show querying
  List<dynamic> productIdListData = [];
  String layout = 'hc';

  Future<void> _requestData(String queryContent, BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    final currentType = preferences.getString('POCKET_GUIDE_INDUSTRY_TYPE');
    if (currentType == 'INDUSTRY') {
      layout = 'industry';
    }
  }

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _requestData(query.trim(), context),
      builder: (context, snapshot) {
        var matchQuery = <dynamic>[];
        if (query.trim().isNotEmpty) {
          matchQuery = DataParse().searchProductByPrdOrName(
            query.toLowerCase().trim(),
            layout,
          );
        }
        return resultListView(context, matchQuery, query.trim());
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _requestData(query.trim(), context),
      builder: (context, snapshot) {
        var matchQuery = <dynamic>[];
        if (query.trim().isNotEmpty) {
          matchQuery = DataParse().searchProductByPrdOrName(
            query.toLowerCase().trim(),
            layout,
          );
        }
        return resultListView(context, matchQuery, query.trim());
      },
    );
  }

  Widget resultListView(
    BuildContext context,
    List<dynamic> dataList,
    String query,
  ) {
    if (dataList.isEmpty && query.isNotEmpty) {
      return const SearchEmptyPage();
    } else {
      pianoFlutterPlugin.trackEvent('internal_search_result.display', {
        'ise_keyword': query,
        'ise_page': 1,
      });
      return ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, i) {
          final favorite = dataList[i] as Map<dynamic, dynamic>;
          final category = HiveDataInjection().checkProductTypeCategory(
            layout,
            ((favorite['product_type'] as List)[0] as Map)['name'].toString(),
          );
          return CustomListTile(
            id: favorite['prd'].toString(),
            productName: favorite['product_name'].toString(),
            isSubProduct: true,
            isFavourite: true,
            category: ProductCategory.categoryDarkBlue,
            onPressed: () {
              SharedPreferences.getInstance().then(
                (value) {
                  final currentType =
                      value.getString('POCKET_GUIDE_INDUSTRY_TYPE');
                  var routePath = AppRoutes.productPortfolioHomeCare.path;
                  if (currentType == 'INDUSTRY') {
                    routePath = AppRoutes.productPortfolioIndustrial.path;
                  }
                  pianoFlutterPlugin
                      .trackEvent('internal_search_result.click', {
                    'ise_keyword': query,
                    'ise_click_rank': dataList.length,
                    'ise_page': 1,
                    'product_name': favorite['product_name'].toString(),
                    'product_prd': favorite['prd'].toString(),
                  });
                  context.push(
                    '$routePath/product/$category/$category/$category/$category',
                    extra: favorite['prd'].toString(),
                  );
                },
              );
            },
          );
        },
      );
    }
  }
}

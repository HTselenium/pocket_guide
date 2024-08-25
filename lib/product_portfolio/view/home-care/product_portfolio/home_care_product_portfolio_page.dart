import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class HomeCareProductPortfolioPage extends StatefulWidget {
  const HomeCareProductPortfolioPage({super.key});

  @override
  State<HomeCareProductPortfolioPage> createState() =>
      _HomeCareProductPortfolioPageState();
}

class _HomeCareProductPortfolioPageState
    extends State<HomeCareProductPortfolioPage> {
  List<Map<String, dynamic>> productTypeListData = [];

  @override
  void initState() {
    super.initState();
    final hcProductTypeBox = Hive.box<dynamic>('hcProductTypeBox');
    productTypeListData =
        hcProductTypeBox.values.map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Builder(
      builder: (context) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              CustomAppBar(
                leading: true,
                title: l10n.productPortfolio,
                onPressed: () {},
              ),
              SliverList(
                //check length more than 10 then show load more button
                delegate: SliverChildListDelegate(
                  List.generate(
                    productTypeListData.length,
                    (i) {
                      return CustomListTile(
                        id: productTypeListData[i]['product_type_id']
                            .toString(),
                        productName:
                            productTypeListData[i]['product_type'].toString(),
                        productNum: productTypeListData[i]
                                ['product_type_amount']
                            .toString(),
                        isSubProduct: false,
                        isFavourite: false,
                        category: ProductCategory
                            .all[productTypeListData[i]['category'] as int],
                        onPressed: () {
                          pianoFlutterPlugin.trackEvent('page.display', {
                            'page': 'product_portfolio_type_page',
                            'product_name': productTypeListData[i]
                                    ['product_type']
                                .toString(),
                            'click_chapter1': 'home_care',
                            'click_chapter2': 'product_portfolio',
                          });
                          (productTypeListData[i]['has_children'] as bool)
                              ? context.push(
                                  '${AppRoutes.productPortfolioHomeCare.path}/product/${productTypeListData[i]['category']}/${productTypeListData[i]['product_type_id']}/${productTypeListData[i]['product_type_id']}',
                                  extra: {
                                    'subtype_id': productTypeListData[i]
                                            ['product_type_id']
                                        .toString(),
                                    'subtype_name': productTypeListData[i]
                                            ['product_type']
                                        .toString(),
                                    'products': productTypeListData[i]
                                        ['products'],
                                  },
                                )
                              : context.push(
                                  '${AppRoutes.productPortfolioHomeCare.path}/product/${productTypeListData[i]['category']}/${productTypeListData[i]['product_type_id']}/',
                                  extra: {
                                    'product_type_id': productTypeListData[i]
                                            ['product_type_id']
                                        .toString(),
                                    'product_type': productTypeListData[i]
                                            ['product_type']
                                        .toString(),
                                    'product_type_amount':
                                        productTypeListData[i]
                                                ['product_type_amount']
                                            .toString(),
                                  },
                                );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

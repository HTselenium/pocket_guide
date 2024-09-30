import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class IndustrialProductPortfolioPage extends StatefulWidget {
  const IndustrialProductPortfolioPage({super.key});

  @override
  State<IndustrialProductPortfolioPage> createState() =>
      _IndustrialProductPortfolioPageState();
}

class _IndustrialProductPortfolioPageState
    extends State<IndustrialProductPortfolioPage> {
  List<Map<String, dynamic>> industrialProductTypeListData = [];

  @override
  void initState() {
    super.initState();
    final industryProductTypeBox = Hive.box<dynamic>('industryProductTypeBox');
    industrialProductTypeListData = industryProductTypeBox.values
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              leading: true,
              title: l10n.productPortfolio,
              onPressed: () {},
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  industrialProductTypeListData.length,
                  (i) {
                    return CustomListTile(
                      id: industrialProductTypeListData[i]['product_type_id'].toString(),
                      productName: industrialProductTypeListData[i]['product_type'].toString(),
                      productNum: industrialProductTypeListData[i]['product_type_amount'].toString(),
                      isSubProduct: true,
                      isFavourite: true,
                      category: ProductCategory.all[industrialProductTypeListData[i]['category'] as int],
                      onPressed: () {
                        pianoFlutterPlugin.trackEvent('page.display', {
                          'page': 'product_portfolio_type_page',
                          'product_name': industrialProductTypeListData[i]['product_type'].toString(),
                          'click_chapter1': 'industrial',
                          'click_chapter2': 'product_portfolio',
                        });
                        (industrialProductTypeListData[i]['has_children'] as bool)
                            ? context.push(
                                '${AppRoutes.productPortfolioIndustrial.path}/product/${industrialProductTypeListData[i]['category']}/${industrialProductTypeListData[i]['product_type_id']}/${industrialProductTypeListData[i]['product_type_id']}',
                                extra: {
                                  'subtype_id': industrialProductTypeListData[i]['product_type_id'].toString(),
                                  'subtype_name': industrialProductTypeListData[i]['product_type'].toString(),
                                  'products': industrialProductTypeListData[i]['products'],  
                                },
                              )
                            : context.push(
                              '${AppRoutes.productPortfolioIndustrial.path}/product/${industrialProductTypeListData[i]['category']}/${industrialProductTypeListData[i]['product_type_id']}/',
                                extra: {
                                  'product_type_id': industrialProductTypeListData[i]['product_type_id'].toString(),
                                  'product_type': industrialProductTypeListData[i]['product_type'].toString(),
                                  'product_type_amount': industrialProductTypeListData[i]['product_type_amount'].toString(),
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
      ),
    );
  }
}

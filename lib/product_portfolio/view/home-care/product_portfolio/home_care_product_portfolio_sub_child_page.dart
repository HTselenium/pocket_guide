import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class HomeCareProductPortfolioSubChildProductPage extends StatefulWidget {
  const HomeCareProductPortfolioSubChildProductPage({
    super.key,
    required this.id,
    required this.portfolioChildInfo,
    required this.category,
  });

  final String id;
  final Map<String, dynamic> portfolioChildInfo;
  final int category;

  @override
  State<HomeCareProductPortfolioSubChildProductPage> createState() =>
      _HomeCareProductPortfolioSubChildProductState();
}

class _HomeCareProductPortfolioSubChildProductState
    extends State<HomeCareProductPortfolioSubChildProductPage> {
  late List<dynamic> _productIdList;
  late Map<String, dynamic> _portfolioChildInfo;
  List<dynamic> productIdListData = [];
  final hcProductBox = Hive.box<dynamic>('hcProductBox');
  @override
  void initState() {
    super.initState();
    _portfolioChildInfo = widget.portfolioChildInfo;
    _productIdList = _portfolioChildInfo['products'] as List<dynamic>;
    for (final productId in _productIdList) {
      productIdListData.add(hcProductBox.get(productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              color: ProductCategory.all[widget.category].color,
              isFirstList: false,
              leading: true,
              title: _portfolioChildInfo['subtype_name'].toString(),
              subtitle: (_portfolioChildInfo['products'] as List<dynamic>)
                  .length
                  .toString(),
              onPressed: () {},
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  productIdListData.length,
                  (i) {
                    return CustomListTile(
                      id: (productIdListData[i] as Map<String, dynamic>)['prd']
                          .toString(),
                      productName: (productIdListData[i]
                              as Map<String, dynamic>)['product_name']
                          .toString(),
                      isSubProduct: true,
                      isFavourite: true,
                      category: ProductCategory.categoryDarkBlue,
                      onPressed: () {
                        pianoFlutterPlugin.trackEvent('page.display', {
                          'page': 'product_detail_page',
                          'page_chapter1': 'home_care',
                          'page_chapter2': 'product_portfolio',
                          'page_chapter3': 'product_detail',
                          'product_prd': (productIdListData[i]
                                  as Map<String, dynamic>)['prd']
                              .toString(),
                          'product_name': (productIdListData[i]
                                  as Map<String, dynamic>)['product_name']
                              .toString(),
                        });
                        context.push(
                          '${AppRoutes.productPortfolioHomeCare.path}/product/${widget.category}/$i/$i/$i',
                          extra: (productIdListData[i]
                                  as Map<String, dynamic>)['prd']
                              .toString(),
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

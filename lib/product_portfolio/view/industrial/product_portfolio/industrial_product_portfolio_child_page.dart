import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class IndustrialProductPortfolioChildPage extends StatefulWidget {
  const IndustrialProductPortfolioChildPage({
    super.key,
    required this.id,
    required this.productPortfolioInfo,
    required this.category,
  });

  final String id;
  final Map<String, dynamic> productPortfolioInfo;
  final int category;

  @override
  State<IndustrialProductPortfolioChildPage> createState() =>
      _IndustrialProductPortfolioChildPageState();
}

class _IndustrialProductPortfolioChildPageState
    extends State<IndustrialProductPortfolioChildPage> {
  late String _id;
  List<dynamic> portfolioChildList = [];
  late Map<String, dynamic> _productPortfolioInfo;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _productPortfolioInfo = widget.productPortfolioInfo;
    final industryProductTypeBox = Hive.box<dynamic>('industryProductTypeBox');
    portfolioChildList = (industryProductTypeBox.get(widget.id)
        as Map<String, dynamic>)['children'] as List<dynamic>;
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
              title: _productPortfolioInfo['product_type'].toString(),
              subtitle: _productPortfolioInfo['product_type_amount'].toString(),
              onPressed: () {},
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  portfolioChildList.length,
                  (i) {
                    return CustomListTile(
                      id: (portfolioChildList[i]
                              as Map<String, dynamic>)['subtype_id']
                          .toString(),
                      productName: (portfolioChildList[i]
                              as Map<String, dynamic>)['subtype_name']
                          .toString(),
                      productNum: ((portfolioChildList[i]
                              as Map<String, dynamic>)['products'] as List)
                          .length
                          .toString(),
                      isSubProduct: true,
                      isFavourite: false,
                      category: ProductCategory.categoryDarkBlue,
                      onPressed: () {
                        pianoFlutterPlugin.trackEvent('page.display', {
                          'page': 'product_portfolio_sub_type_page',
                          'product_name': (portfolioChildList[i]
                                  as Map<String, dynamic>)['subtype_name']
                              .toString(),
                          'page_chapter1': 'industrial',
                          'page_chapter2': 'product_portfolio',
                          'page_chapter3': 'product_portfolio_group',
                        });
                        context.push(
                          '${AppRoutes.productPortfolioIndustrial.path}/product/${widget.category}/$_id/${(portfolioChildList[i] as Map<String, dynamic>)['subtype_id']}/',
                          extra: portfolioChildList[i] as Map<String, dynamic>,
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

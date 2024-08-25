import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class SustainabilityIndustrialPage extends StatefulWidget {
  const SustainabilityIndustrialPage({super.key});

  @override
  State<SustainabilityIndustrialPage> createState() =>
      _SustainabilityIndustrialState();
}

class _SustainabilityIndustrialState
    extends State<SustainabilityIndustrialPage> {
  List<Map<String, dynamic>> sustainabilityList = [];

  @override
  void initState() {
    super.initState();
    final industrySustainabilityBox =
        Hive.box<dynamic>('industrySustainabilityBox');
    sustainabilityList = industrySustainabilityBox.values
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
              title: l10n.sustainability,
              onPressed: () {},
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  sustainabilityList.length,
                  (i) {
                    return CustomListTile(
                      id: '$i',
                      productName:
                          sustainabilityList[i]['sustainability'].toString(),
                      productNum: (sustainabilityList[i]['prd'] as List)
                          .length
                          .toString(),
                      isSubProduct: false,
                      isFavourite: false,
                      category: ProductCategory.categoryLightGreen,
                      onPressed: () {
                        pianoFlutterPlugin.trackEvent('page.display', {
                          'page': 'sustainability_type_page',
                          'product_name': sustainabilityList[i]
                                  ['sustainability']
                              .toString(),
                          'click_chapter1': 'industrial',
                          'click_chapter2': 'sustainability',
                        });
                        context.pushNamed(
                          'sustainabilityIndustrial',
                          params: {'id': '$i'},
                          extra: {
                            'subtype_name': sustainabilityList[i]
                                ['sustainability'],
                            'claim_id': i.toString(),
                            'products': sustainabilityList[i]['prd'],
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

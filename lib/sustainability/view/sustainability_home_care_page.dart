import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class SustainabilityHCPage extends StatefulWidget {
  const SustainabilityHCPage({super.key});

  @override
  State<SustainabilityHCPage> createState() => _SustainabilityHCState();
}

class _SustainabilityHCState extends State<SustainabilityHCPage> {
  List<Map<String, dynamic>> sustainabilityList = [];

  @override
  void initState() {
    super.initState();
    final hcSustainabilityBox = Hive.box<dynamic>('hcSustainabilityBox');
    sustainabilityList = hcSustainabilityBox.values
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
                      productName: sustainabilityList[i]['sustainability_name']
                          .toString(),
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
                                  ['sustainability_name']
                              .toString(),
                          'click_chapter1': 'home_care',
                          'click_chapter2': 'sustainability',
                        });
                        context.pushNamed(
                          'sustainabilityHomeCare',
                          params: {'id': '$i'},
                          extra: {
                            'subtype_name': sustainabilityList[i]
                                ['sustainability_name'],
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class ClaimPage extends StatefulWidget {
  const ClaimPage({super.key});
  @override
  State<ClaimPage> createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> {
  List<Map<String, dynamic>> claimsDataList = [];
  @override
  void initState() {
    super.initState();
    final hcClaimsBox = Hive.box<dynamic>('hcClaimsBox');
    claimsDataList =
        hcClaimsBox.values.map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              title: l10n.claims,
              leading: true,
              onPressed: () {},
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  claimsDataList.length,
                  (i) {
                    return CustomListTile(
                      id: claimsDataList[i]['application_id'].toString(),
                      productName: claimsDataList[i]['application'].toString(),
                      //helper.name,
                      productNum:
                          claimsDataList[i]['application_amount'].toString(),
                      //helper.number',
                      isFavourite: false,
                      //helper.isFav,
                      isSubProduct: false,
                      //helper.isSubProd,
                      category: ProductCategory.categoryOrange,
                      onPressed: () {
                        pianoFlutterPlugin.trackEvent('page.display', {
                          'page': 'claim_type_page',
                          'product_name':
                              claimsDataList[i]['application'].toString(),
                          'page_chapter1': 'claims_page',
                        });
                        context.push(
                          '${AppRoutes.claims.path}/subclaim/${claimsDataList[i]['application_id']}',
                          extra: {
                            'application': claimsDataList[i]['application'],
                            'application_id': claimsDataList[i]
                                ['application_id'],
                            'application_amount': claimsDataList[i]
                                ['application_amount'],
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class SubClaimPage extends StatefulWidget {
  const SubClaimPage({
    super.key,
    required this.id,
    required this.applicationInfo,
  });

  final String id;
  final Map<String, dynamic> applicationInfo;
  @override
  State<SubClaimPage> createState() => _SubClaimPageState();
}

class _SubClaimPageState extends State<SubClaimPage> {
  late String _id;
  late Map<String, dynamic> _applicationInfo;
  List<Map<String, dynamic>> functionClaimList = [];

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _applicationInfo = widget.applicationInfo;

    final hcClaimsBox = Hive.box<dynamic>('hcClaimsBox');
    final functionObj = hcClaimsBox.values.firstWhere(
      (element) => (element as Map)['application_id'].toString() == _id,
    );
    functionClaimList = ((functionObj as Map)['children'] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              color: ProductCategory.categoryOrange.color,
              isFirstList: false,
              leading: true,
              onPressed: () {},
              subtitle: _applicationInfo['application_amount'].toString(),
              title: _applicationInfo['application'].toString(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  functionClaimList.length,
                  (i) {
                    return CustomListTile(
                      id: functionClaimList[i]['function_claim_id'].toString(),
                      productName: functionClaimList[i]['function_claim_name']
                          .toString(),
                      //helper.name,
                      productNum: functionClaimList[i]['function_claim_amount']
                          .toString(),
                      // helper.number,
                      isFavourite: false,
                      isSubProduct: true,
                      category: ProductCategory.categoryRed,
                      onPressed: () {
                        pianoFlutterPlugin.trackEvent('page.display', {
                          'page': 'claim_sub_type_page',
                          'product_name': functionClaimList[i]
                                  ['function_claim_name']
                              .toString(),
                          'page_chapter1': 'claim_page',
                          'page_chapter2': 'claim_group',
                        });
                        context.push(
                          '${AppRoutes.claims.path}/subclaim/$_id/${functionClaimList[i]['function_claim_id']}',
                          extra: {
                            'function_claim_name': functionClaimList[i]
                                ['function_claim_name'],
                            'function_claim_id': functionClaimList[i]
                                ['function_claim_id'],
                            'function_claim_amount': functionClaimList[i]
                                ['function_claim_amount'],
                            'application_id': _id,
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

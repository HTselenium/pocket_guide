import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class ClaimsClaimPage extends StatefulWidget {
  const ClaimsClaimPage({
    super.key,
    required this.id,
    required this.functionClaimInfo,
  });

  final String id;
  final Map<String, dynamic> functionClaimInfo;
  @override
  State<ClaimsClaimPage> createState() => _ClaimsClaimPageState();
}

class _ClaimsClaimPageState extends State<ClaimsClaimPage> {
  late String _id;
  late Map<String, dynamic> _functionClaimInfo;
  List<dynamic> claimList = [];

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _functionClaimInfo = widget.functionClaimInfo;
    final hcClaimsBox = Hive.box<dynamic>('hcClaimsBox');

    final applicationObj = hcClaimsBox
        .get(int.parse(_functionClaimInfo['application_id'].toString())) as Map;
    final functionObj = (applicationObj['children'] as List).firstWhere(
      (element) => (element as Map)['function_claim_id'].toString() == _id,
    ) as Map;
    claimList = functionObj['children'] as List;
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
              subtitle: _functionClaimInfo['function_claim_amount'].toString(),
              title: _functionClaimInfo['function_claim_name'].toString(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  claimList.length,
                  (i) {
                    return CustomListTile(
                      id: (claimList[i] as Map)['claim_id'].toString(),
                      productName:
                          (claimList[i] as Map)['claim_name'].toString(),
                      //helper.name,
                      productNum: ((claimList[i] as Map)['products'] as List)
                          .length
                          .toString(),
                      // helper.number,
                      isFavourite: false,
                      isSubProduct: true,
                      category: ProductCategory.categoryRed,
                      onPressed: () {
                        context.push(
                          '${AppRoutes.claims.path}/subclaim/${_functionClaimInfo['application_id']}/$_id/${(claimList[i] as Map)['claim_id']}',
                          extra: {
                            'subtype_name': (claimList[i] as Map)['claim_name'],
                            'claim_id': (claimList[i] as Map)['claim_id'],
                            'products': (claimList[i] as Map)['products'],
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

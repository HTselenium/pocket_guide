import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/product_details/models/products_category_enum.dart';

class ClaimGroupPage extends StatefulWidget {
  const ClaimGroupPage({
    super.key,
    required this.category,
    required this.prodName,
    this.claimsList,
    required this.id,
  });

  final String id;
  final List<dynamic>? claimsList;
  final int category;
  final String prodName;

  @override
  State<ClaimGroupPage> createState() => _ClaimGroupPageState();
}

class _ClaimGroupPageState extends State<ClaimGroupPage> {
  List<dynamic>? _claimList = [];

  @override
  void initState() {
    super.initState();
    _claimList = widget.claimsList;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              isFirstList: false,
              color: ProductCategory.all[widget.category].color,
              leading: true,
              title: widget.prodName,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  _claimList!.length,
                  (i) {
                    return Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: ProductCategory.categoryOrange.color
                                  .withOpacity(0.2),
                            ),
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            childrenPadding: const EdgeInsets.only(left: 10),
                            textColor: const Color(AppTheme.blackColor),
                            iconColor: const Color(AppTheme.blackColor),
                            title: Text(
                              (_claimList![i] as Map)['name'].toString(),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.orange,
                              ),
                            ),
                            children: ((_claimList![i] as Map)['children']
                                    as List)
                                .map(
                                  (child) => ExpansionTile(
                                    initiallyExpanded: true,
                                    childrenPadding:
                                        const EdgeInsets.only(left: 10),
                                    iconColor: const Color(AppTheme.blackColor),
                                    textColor: const Color(AppTheme.blackColor),
                                    title: Text(
                                      (child as Map)['name'].toString(),
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    children: (child['children'] as List)
                                        .map(
                                          (e) => ListTile(
                                            title: Text(
                                              (e as Map)['name'].toString(),
                                              style: theme.textTheme.bodyLarge,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ).padded(
                      const EdgeInsets.only(
                        left: Dimens.paddingMedium20,
                        right: Dimens.paddingMedium20,
                        top: Dimens.paddingMedium,
                      ),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/core/data/data_parse.dart';
import 'package:pocket_guide/product_details/product_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPage();
}

class _FavoritesPage extends State<FavoritesPage> {
  Future<List<dynamic>> favoritesDataFuture = DataParse().getFavProductList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return favoritesDataFuture = DataParse().getFavProductList();
        },
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              color: ProductCategory.categoryDarkBlue.color,
              leading: false,
              title: 'Favorites',
              onPressed: () {},
            ),
            FutureBuilder(
              future: favoritesDataFuture,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  if (snapshot.data!.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text("You don't have any favorites yet"),
                      ),
                    );
                  } else {
                    return SliverList(
                      delegate: SliverChildListDelegate(
                        _buildFavoritesList(snapshot.data!, context),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFavoritesList(
    List<dynamic> favoritesData,
    BuildContext context,
  ) {
    return List.generate(
      favoritesData.length,
      (i) {
        final favorite = favoritesData[i] as Map<String, dynamic>;
        return CustomListTile(
          id: favorite['prd'].toString(),
          productName: favorite['product_name'].toString(),
          isSubProduct: true,
          isFavourite: true,
          category: ProductCategory.categoryDarkBlue,
          onPressed: () {
            SharedPreferences.getInstance().then(
              (value) {
                final currentType =
                    value.getString('POCKET_GUIDE_INDUSTRY_TYPE');
                var routePath = AppRoutes.productPortfolioHomeCare.path;
                if (currentType == 'INDUSTRY') {
                  routePath = AppRoutes.productPortfolioIndustrial.path;
                }
                context.push(
                  '$routePath/product/$i/$i/$i/$i',
                  extra: favorite['prd'].toString(),
                );
              },
            );
          },
        );
      },
    );
  }
}

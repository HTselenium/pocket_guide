import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataInjection {
  String hcJsonFilePath = 'assets/documents/HC/pocket_guide_HC_20240506.json';
  String industryJsonFilePath =
      'assets/documents/Industrial/PocketGuideUpdate-2024-01-19.json';
  String hcProductTypeJsonFilePath =
      'assets/documents/HC/pocket_guide_HC_product_type_20240506.json';
  String industryProductTypeJsonFilePath =
      'assets/documents/Industrial/PocketGuideUpdate-product_type-2024-01-19.json';
  String hcClaimsFilePath =
      'assets/documents/HC/pocket_guide_HC_claims_11102023.json';
  String hcSustainabilityPath =
      'assets/documents/HC/pocket_guide_HC_sustainability_20240506.json';
  String industrySustainabilityPath =
      'assets/documents/Industrial/PocketGuideUpdate_Sustainability_Categories-2024-01-19.json';

  Future<List<dynamic>> getJsonFromAssets(String asset) async {
    final productTypeData = await rootBundle.loadString(asset);

    final productTypeList = json.decode(productTypeData) as List<dynamic>;
    return productTypeList;
  }

  Future<void> dataInjection() async {
    await productDataInjection();
    await productTypeDataInjection();
    await claimsDataInjection();
    await sustainabilityDataInjection();
  }

  Future<void> productDataInjection() async {
    final hcProductList = await getJsonFromAssets(hcJsonFilePath);
    final hcProductBox = await Hive.openBox<dynamic>('hcProductBox');
    // await hcProductBox.delete('hcProductList');
    for (final product in hcProductList) {
      await hcProductBox.put((product as Map)['prd'], product);
    }

    final industryProductList = await getJsonFromAssets(industryJsonFilePath);
    final industryProductBox =
        await Hive.openBox<dynamic>('industryProductBox');
    // await industryProductBox.delete('industryProductList');
    for (final product in industryProductList) {
      await industryProductBox.put((product as Map)['prd'], product);
    }
  }

  Future<void> productTypeDataInjection() async {
    final hcProductTypeList =
        await getJsonFromAssets(hcProductTypeJsonFilePath);
    final hcProductTypeBox = await Hive.openBox<dynamic>('hcProductTypeBox');
    parseProductTypeData('HC', hcProductTypeBox, hcProductTypeList);

    final industryProductList =
        await getJsonFromAssets(industryProductTypeJsonFilePath);
    final industryProductTypeBox =
        await Hive.openBox<dynamic>('industryProductTypeBox');
    parseProductTypeData(
      'Industry',
      industryProductTypeBox,
      industryProductList,
    );
  }

  void parseProductTypeData(
    String layout,
    Box<dynamic> typeBox,
    List<dynamic> typeList,
  ) {
    typeList.sort(
      (a, b) => ((a as Map)['product_type_id'] as int)
          .compareTo((b as Map)['product_type_id'] as int),
    );
    // final productTypeDisplayList = <Map<String, dynamic>>[];
    for (final type in typeList) {
      var productTypeAmount = 0;
      var hasChildren = false;
      if ((type as Map).keys.contains('children')) {
        hasChildren = true;
        (type['children'] as List).sort(
          (a, b) => ((a as Map)['subtype_id'] as int)
              .compareTo((b as Map)['subtype_id'] as int),
        );
        for (final subType in type['children'] as List) {
          productTypeAmount += ((subType as Map)['products'] as List).length;
        }
        type['product_type_amount'] = productTypeAmount;
        type['has_children'] = hasChildren;
        type['category'] =
            checkProductTypeCategory(layout, type['product_type'].toString());
      } else {
        type['product_type_amount'] = (type['products'] as List).length;
        type['has_children'] = hasChildren;
        type['category'] =
            checkProductTypeCategory(layout, type['product_type'].toString());
      }
      typeBox.put(type['product_type_id'].toString(), type);
    }
  }

  int checkProductTypeCategory(String layout, String productTypeName) {
    var category = 0;
    if (layout == 'HC') {
      if (productTypeName.contains('Surfactants')) {
        category = 0;
      } else if (productTypeName.contains('Performance') ||
          productTypeName.contains('Waxes')) {
        category = 1;
      } else if (productTypeName.contains('Chelating')) {
        category = 2;
      } else if (productTypeName.contains('Metal') ||
          productTypeName.contains('Acids') ||
          productTypeName.contains('Biocides') ||
          productTypeName.contains('Optical')) {
        category = 3;
      } else if (productTypeName.contains('Enzymes')) {
        category = 5;
      }
    } else {
      if (productTypeName.contains('Surfactants') ||
          productTypeName.contains('Alcohols') ||
          productTypeName.contains('Waxes')) {
        category = 0;
      } else if (productTypeName.contains('Water')) {
        category = 1;
      } else if (productTypeName.contains('Chelating')) {
        category = 2;
      } else if (productTypeName.contains('Metal') ||
          productTypeName.contains('Biocides')) {
        category = 3;
      } else if (productTypeName.contains('Soluble')) {
        category = 4;
      } else if (productTypeName.contains('Acid') ||
          productTypeName.contains('Amides')) {
        category = 5;
      }
    }
    return category;
  }

  Future<void> claimsDataInjection() async {
    final claimsList = await getJsonFromAssets(hcClaimsFilePath);
    final hcClaimsBox = await Hive.openBox<dynamic>('hcClaimsBox');
    claimsList.sort(
      (a, b) => ((a as Map)['application_id'] as int)
          .compareTo((b as Map)['application_id'] as int),
    );
    for (final app in claimsList) {
      var appAmount = 0;
      ((app as Map)['children'] as List).sort(
        (a, b) => ((a as Map)['function_claim_id'] as int)
            .compareTo((b as Map)['function_claim_id'] as int),
      );
      for (final func in app['children'] as List) {
        var funcAmount = 0;
        ((func as Map)['children'] as List).sort(
          (a, b) => ((a as Map)['claim_id'] as int)
              .compareTo((b as Map)['claim_id'] as int),
        );
        for (final claim in func['children'] as List) {
          appAmount += ((claim as Map)['products'] as List).length;
          funcAmount += (claim['products'] as List).length;
        }
        func['function_claim_amount'] = funcAmount;
      }
      app['application_amount'] = appAmount;
      await hcClaimsBox.put(app['application_id'], app);
    }
    // await hcClaimsBox.put('hcClaimsList', claimsList);
  }

  Future<void> sustainabilityDataInjection() async {
    final hcSustainabilityList = await getJsonFromAssets(hcSustainabilityPath);
    final industrySustainabilityList =
        await getJsonFromAssets(industrySustainabilityPath);
    final hcSustainabilityBox =
        await Hive.openBox<dynamic>('hcSustainabilityBox');
    final industrySustainabilityBox =
        await Hive.openBox<dynamic>('industrySustainabilityBox');

    for (final sus in hcSustainabilityList) {
      switch ((sus as Map)['sustainability']) {
        case 'bioBased':
          sus['sustainability_name'] = 'Bio-based Products';
          sus['order'] = 4;
          break;
        case 'bioDegradable':
          sus['sustainability_name'] = 'Biodegradable Products';
          sus['order'] = 1;
          break;
        case 'blueAngel':
          sus['sustainability_name'] = 'Suitable for Blue Angel';
          sus['order'] = 6;
          break;
        case 'ecoCert':
          sus['sustainability_name'] = 'Suitable for Ecocert';
          sus['order'] = 8;
          break;
        case 'ecoLabel':
          sus['sustainability_name'] = 'Suitable for EU EcoLabel';
          sus['order'] = 5;
          break;
        // case 'isEcoBalanced':
        //   sus['sustainability_name'] = 'EcoBalanced Products';
        //   sus['order'] = 3;
        //   break;
        case 'nordicSwan':
          sus['sustainability_name'] = 'Suitable for Nordic Swan';
          sus['order'] = 7;
          break;
        case 'rspo':
          sus['sustainability_name'] =
              'Roundtable on Sustainable Palm Oil (RSPO)';
          sus['order'] = 2;
          break;
      }
      await hcSustainabilityBox.put(
        sus['sustainability'].toString(),
        sus,
      );
    }
    hcSustainabilityList.sort(
      (a, b) =>
          ((a as Map)['order'] as int).compareTo((b as Map)['order'] as int),
    );
    // await hcSustainabilityBox.put(
    //   'hcSustainabilityList',
    //   hcSustainabilityList,
    // );

    for (final sus in industrySustainabilityList) {
      await industrySustainabilityBox.put(
        (sus as Map)['sustainability'].toString(),
        sus,
      );
    }
    // await industrySustainabilityBox.put(
    //   'industrySustainabilityList',
    //   industrySustainabilityList,
    // );
  }

// Future<List<dynamic>> getProductList(
//   List<dynamic> productIdList,
//   String layout,
// ) async {
//   final productList = <dynamic>[];
//   final Box<dynamic> productBox;
//   if (layout.contains('hc')) {
//     productBox = Hive.box('hcProductBox');
//   } else {
//     productBox = Hive.box('industryProductBox');
//   }
//   for (final productId in productIdList) {
//     productList.add(productBox.get(productId.toString()));
//   }
//   return productList;
// }
}

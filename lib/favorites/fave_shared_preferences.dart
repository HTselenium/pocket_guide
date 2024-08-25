import 'dart:developer';
import 'package:pocket_guide/get_it_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaveSharedPreferences {

  static Future<String> getFaveListStoreKey() async{
    final preferences = await SharedPreferences.getInstance();
    final currentType = preferences.getString('POCKET_GUIDE_INDUSTRY_TYPE');
    var favListStoreKey = 'POCKET_GUIDE_HOME_CARE_FAV_LIST'; //defalut homecare
    if (currentType == 'INDUSTRY'){
      favListStoreKey = 'POCKET_GUIDE_INDUSTRY_FAV_LIST';
    }
    return favListStoreKey;
  }
  static Future<dynamic> setFave({required String id,required String productName}) async {
    pianoFlutterPlugin.trackEvent('click.action',{
      'click':'product_set_favorite',
      'product_prd':id,
      'product_name':productName,
    });

    final preferences = await SharedPreferences.getInstance();
    final favListStoreKey = await getFaveListStoreKey();
    List<String>? favList = [];
    if (preferences.getStringList(favListStoreKey) != null) {
      favList = preferences.getStringList(favListStoreKey);
    }
    if (favList?.contains(id) == false) {
      favList?.add(id);
    }
    await preferences.setStringList(favListStoreKey, favList!);
    log('saved in list $favList');
  }

  static Future<dynamic> removeFav({required String id,required String productName}) async {
    pianoFlutterPlugin.trackEvent('click.action',{
      'click':'product_remove_favorite',
      'product_prd':id,
      'product_name':productName,
    });
    final preferences = await SharedPreferences.getInstance();
    final favListStoreKey = await getFaveListStoreKey();
    List<String>? favList = [];
    if (preferences.getStringList(favListStoreKey) != null) {
      favList = preferences.getStringList(favListStoreKey);
    }
    favList?.remove(id);
    await preferences.setStringList(favListStoreKey, favList!);
    log('removed in list $favList');
  }

  static Future<bool> checkFavByProductId(String id) async {
    final preferences = await SharedPreferences.getInstance();
    final favListStoreKey = await getFaveListStoreKey();
    List<String>? favList = [];
    if (preferences.getStringList(favListStoreKey) != null) {
      favList = preferences.getStringList(favListStoreKey);
    }
    if (favList?.contains(id) == false) {
      return false;
    } else {
      return true;
    }
  }
}

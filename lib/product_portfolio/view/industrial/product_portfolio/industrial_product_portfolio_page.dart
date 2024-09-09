## industrial_product_portfolio_page.dart

- ### initState

```dart
void initState() {
    super.initState();
    final industryProductTypeBox = Hive.box<dynamic>('industryProductTypeBox');
    industrialProductTypeListData = industryProductTypeBox.values
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
```
- ### page display
```dart
id: industrialProductTypeListData[i]['product_type_id'].toString(),
productName: industrialProductTypeListData[i]['product_type'].toString(),
productNum: industrialProductTypeListData[i]['product_type_amount'].toString(),
isSubProduct: false,
isFavourite: false,
category: ProductCategory.all[industrialProductTypeListData[i]['category'] as int],

```
- ### data dispatch
**check whether productType has children**
```dart
industrialProductTypeListData[i]['has_children']
```
**if True (has children)** 
goes to industrial_product_portfolio_child_page.dart
```dart
 context.push(
 
 '${AppRoutes.productPortfolioIndustrial.path}/product/${industrialProductTypeListData[i]['category']}/${industrialProductTypeListData[i]['product_type_id']}/',
extra: {
 'product_type_id':industrialProductTypeListData[i]['product_type_id'].toString(),
 'product_type':industrialProductTypeListData[i]['product_type'].toString(),
 'product_type_amount':industrialProductTypeListData[i]['product_type_amount'].toString(),
},
```
**if False (does not have children)** 
goes to industrial_product_portfolio_sub_child_page.dart

```dart
context.push(
'${AppRoutes.productPortfolioIndustrial.path}/product/${industrialProductTypeListData[i]['category']}/${industrialProductTypeListData[i]['product_type_id']}/${industrialProductTypeListData[i]['product_type_id']}',
extra: {
 'subtype_id': industrialProductTypeListData[i]['product_type_id'].toString(),
 'subtype_name':industrialProductTypeListData[i]['product_type'].toString(),
 'products': industrialProductTypeListData[i]['products'],
```

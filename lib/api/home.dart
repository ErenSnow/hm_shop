import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

// 轮播图列表
Future<List<BannerItem>> getBannerListApi() async {
  return ((await diorequest.get(HttpConstants.BANNER_LIST)) as List).map((
    item,
  ) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

// 分类列表
Future<List<Category>> getCategoryListApi() async {
  return ((await diorequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return Category.fromJson(item as Map<String, dynamic>);
  }).toList();
}

// 特惠推荐
Future<RecommendSection> getRecommendSectionListApi() async {
  return RecommendSection.fromJson(
    await diorequest.get(HttpConstants.PREFERENCE_LIST),
  );
}

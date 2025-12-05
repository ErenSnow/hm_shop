import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> bannerList = [];
  List<Category> categoryList = [];
  RecommendSection recommendSection = RecommendSection(
    id: "",
    title: "",
    subTypes: [],
  );
  RecommendSection inVogueSection = RecommendSection(
    id: "",
    title: "",
    subTypes: [],
  );
  RecommendSection oneStopSection = RecommendSection(
    id: "",
    title: "",
    subTypes: [],
  );
  List<GoodDetailItem> recommendList = [];
  List<Widget> _buildSlivers() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(recommendSection: recommendSection),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(
                  subType:
                      inVogueSection.subTypes != null &&
                          inVogueSection.subTypes!.isNotEmpty
                      ? inVogueSection.subTypes![0]
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: HmHot(
                  subType:
                      oneStopSection.subTypes != null &&
                          oneStopSection.subTypes!.isNotEmpty
                      ? oneStopSection.subTypes![0]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: recommendList),
    ];
  }

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getRecommendSection();
    _getInVogueSection();
    _getOneStopSection();
    _getRecommendList();
  }

  void _getBannerList() async {
    bannerList = await getBannerListApi();
    setState(() {});
  }

  void _getCategoryList() async {
    categoryList = await getCategoryListApi();
    setState(() {});
  }

  void _getRecommendSection() async {
    recommendSection = await getRecommendSectionListApi();
    setState(() {});
  }

  void _getInVogueSection() async {
    inVogueSection = await getInVogueSectionListApi();
    setState(() {});
  }

  void _getOneStopSection() async {
    oneStopSection = await getOneStopSectionListApi();
    setState(() {});
  }

  void _getRecommendList() async {
    recommendList = await getRecommendListApi({"limit": 10});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _buildSlivers());
  }
}

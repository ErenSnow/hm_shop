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
  final ScrollController _scrollController = ScrollController();
  
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
    _registerEvent();
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 50)) {
        _getRecommendList();
      }
    });
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

  int _page = 1; // 当前页码
  bool _isLoading = false; // 是否正在加载
  bool _hasMore = true; // 是否有更多数据

  void _getRecommendList() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    int limit = _page * 10;
    recommendList = await getRecommendListApi({"limit": limit});
    _isLoading = false;
    setState(() {});
    if (recommendList.length < limit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _buildSlivers(),
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

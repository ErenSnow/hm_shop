import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabList = [
    {
      "title": "首页",
      "icon": "lib/assets/ic_nav_lite_home.png",
      "active_icon": "lib/assets/ic_nav_lite_home_sel.png",
    },
    {
      "title": "分类",
      "icon": "lib/assets/ic_nav_lite_portfolio.png",
      "active_icon": "lib/assets/ic_nav_lite_portfolio_sel.png",
    },
    {
      "title": "购物车",
      "icon": "lib/assets/ic_nav_lite_message.png",
      "active_icon": "lib/assets/ic_nav_lite_message_sel.png",
    },
    {
      "title": "会员中心",
      "icon": "lib/assets/ic_nav_lite_assets.png",
      "active_icon": "lib/assets/ic_nav_lite_assets_sel.png",
    },
  ];

  List<BottomNavigationBarItem> _getBottomNavItems() {
    return _tabList.map((tab) {
      return BottomNavigationBarItem(
        icon: Image.asset(tab['icon']!, width: 24, height: 24),
        activeIcon: Image.asset(tab['active_icon']!, width: 24, height: 24),
        label: tab['title'],
      );
    }).toList();
  }

  int _currentIndex = 0;

  List<Widget> _getTabPages() {
    return [
      Center(child: HomeView()),
      Center(child: CategoryView()),
      Center(child: CartVew()),
      Center(child: MineView()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getTabPages()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        items: _getBottomNavItems(),
      ),
    );
  }
}

/*
 * 管理路由
 */
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(initialRoute: "/", routes: getRootRoutes());
}

// 返回该App的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {"/": (context) => MainPage(), "/login": (context) => LoginPage()};
}

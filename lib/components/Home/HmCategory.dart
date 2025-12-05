import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 分类组件
/// 显示横向滚动的分类列表，每个分类包含圆形图标和名称
class HmCategory extends StatefulWidget {
  final List<Category> categoryList;
  const HmCategory({super.key, required this.categoryList});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final category = widget.categoryList[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 圆形图标容器
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child:
                      category.picture != null && category.picture!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            category.picture!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // 图片加载失败时显示占位符
                              return Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.category,
                                  color: Colors.grey[400],
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        )
                      : Icon(Icons.category, color: Colors.grey[400], size: 30),
                ),
                const SizedBox(height: 6),
                // 分类名称
                Text(
                  category.name ?? "",
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
      ),
    );
  }
}

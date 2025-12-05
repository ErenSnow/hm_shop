import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 更多商品列表组件
/// 使用网格布局展示推荐商品列表，支持滚动加载
class HmMoreList extends StatefulWidget {
  final List<GoodDetailItem> recommendList;
  const HmMoreList({super.key, required this.recommendList});

  @override
  State<HmMoreList> createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    // 如果没有数据，返回空占位符
    if (widget.recommendList.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          final goodsItem = widget.recommendList[index];
          return _buildGoodsCard(goodsItem);
        }, childCount: widget.recommendList.length),
      ),
    );
  }

  /// 构建商品卡片
  Widget _buildGoodsCard(GoodDetailItem goodsItem) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 商品图片
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: goodsItem.picture != null && goodsItem.picture!.isNotEmpty
                  ? Image.network(
                      goodsItem.picture!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // 图片加载失败时显示占位符
                        return Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        );
                      },
                    )
                  : Container(
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 40,
                      ),
                    ),
            ),
          ),
          // 商品信息
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 商品名称
                Text(
                  goodsItem.name ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // 商品描述
                if (goodsItem.desc != null && goodsItem.desc!.isNotEmpty)
                  Text(
                    goodsItem.desc!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 4),
                // 商品价格和销量
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 价格
                    Text(
                      goodsItem.price != null ? "¥${goodsItem.price}" : "¥0.00",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // 销量
                    if (goodsItem.payCount > 0)
                      Text(
                        "已售${goodsItem.payCount}",
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

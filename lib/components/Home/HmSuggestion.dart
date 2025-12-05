import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 推荐商品组件
/// 显示推荐区块中的商品列表，使用网格布局展示商品图片和文字信息
class HmSuggestion extends StatefulWidget {
  final RecommendSection recommendSection;
  const HmSuggestion({super.key, required this.recommendSection});

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  /// 从 RecommendSection 中提取所有商品项
  List<GoodsItem> _getAllGoodsItems() {
    List<GoodsItem> allItems = [];
    if (widget.recommendSection.subTypes != null) {
      for (var subType in widget.recommendSection.subTypes!) {
        if (subType.goodsItems?.items != null) {
          allItems.addAll(subType.goodsItems!.items!);
        }
      }
    }
    return allItems;
  }

  @override
  Widget build(BuildContext context) {
    final items = _getAllGoodsItems();
    
    // 如果没有商品，返回空容器
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          if (widget.recommendSection.title != null && widget.recommendSection.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.recommendSection.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          // 商品网格
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final goodsItem = items[index];
              return _buildGoodsCard(goodsItem);
            },
          ),
        ],
      ),
    );
  }

  /// 构建商品卡片
  Widget _buildGoodsCard(GoodsItem goodsItem) {
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 4),
                // 商品价格
                Text(
                  goodsItem.price != null ? "¥${goodsItem.price}" : "¥0.00",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 热门商品组件
/// 显示一个子类型的商品列表，使用垂直列表展示商品信息
class HmHot extends StatefulWidget {
  final SubType? subType;
  const HmHot({super.key, this.subType});

  @override
  State<HmHot> createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    // 如果没有数据，显示占位符
    if (widget.subType == null ||
        widget.subType!.goodsItems?.items == null ||
        widget.subType!.goodsItems!.items!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          "暂无数据",
          style: TextStyle(color: Colors.grey[400], fontSize: 14),
        ),
      );
    }

    final items = widget.subType!.goodsItems!.items!;
    // 最多显示3个商品
    final displayItems = items.length > 3 ? items.sublist(0, 3) : items;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题
          if (widget.subType!.title != null &&
              widget.subType!.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.subType!.title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          // 商品列表
          ...displayItems.asMap().entries.map((entry) {
            final index = entry.key;
            final goodsItem = entry.value;
            return _buildGoodsItem(
              goodsItem,
              index < displayItems.length - 1,
            );
          }).toList(),
        ],
      ),
    );
  }

  /// 构建商品项
  Widget _buildGoodsItem(GoodsItem goodsItem, bool showDivider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 商品图片
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: goodsItem.picture != null && goodsItem.picture!.isNotEmpty
                    ? Image.network(
                        goodsItem.picture!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                              size: 24,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                      ),
              ),
              const SizedBox(width: 10),
              // 商品信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 商品名称
                    Text(
                      goodsItem.name ?? "",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // 商品价格
                    Text(
                      goodsItem.price != null ? "¥${goodsItem.price}" : "¥0.00",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 分隔线
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: 12,
            endIndent: 12,
          ),
      ],
    );
  }
}

class BannerItem {
  final String? id;
  final String? imgUrl;

  BannerItem({required this.imgUrl, required this.id});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? "", imgUrl: json['imgUrl'] ?? "");
  }
}

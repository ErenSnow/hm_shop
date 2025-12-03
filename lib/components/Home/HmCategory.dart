import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  const HmCategory({super.key});

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
          return Container(
            width: 80,
            margin: const EdgeInsets.all(8),
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                "分类$index",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 20,
      ),
    );
  }
}

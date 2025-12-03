import 'package:flutter/material.dart';

class HmHot extends StatefulWidget {
  const HmHot({super.key});

  @override
  State<HmHot> createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 150,
      alignment: Alignment.center,
      child: Text("热门", style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}

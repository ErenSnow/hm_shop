import 'package:flutter/material.dart';

class HmSuggestion extends StatefulWidget {
  const HmSuggestion({super.key});

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        color: Colors.blue,
        height: 200,
        alignment: Alignment.center,
        child: Text("推荐", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}

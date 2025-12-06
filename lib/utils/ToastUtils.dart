import 'package:flutter/material.dart';

class ToastUtils {
  // 阀门控制
  static bool _isShowLoading = false;
  static void show(BuildContext context, String message) {
    if (_isShowLoading) return;
    _isShowLoading = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
    Future.delayed(Duration(seconds: 2), () {
      _isShowLoading = false;
    });
  }
}

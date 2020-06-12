import 'package:flutter/material.dart';

///自定义加载view
class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

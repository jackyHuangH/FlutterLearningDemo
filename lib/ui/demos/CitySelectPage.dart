import 'package:flutter/material.dart';

///城市选择demo
class CitySelectPage extends StatefulWidget {
  String title;

  CitySelectPage(this.title);

  @override
  _CitySelectPageState createState() => _CitySelectPageState();
}

class _CitySelectPageState extends State<CitySelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
    );
  }
}

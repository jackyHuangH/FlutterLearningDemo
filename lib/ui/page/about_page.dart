import 'package:flutter/material.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/index.dart';

///关于页面
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtils.getString(context, Ids.titleAbout)),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Image.asset('')
        ],
      ),
    );
  }
}

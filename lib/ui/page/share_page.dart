import 'package:flutter/material.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/strings.dart';

///分享页面
class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtils.getString(context, Ids.titleShare)),
        centerTitle: true,
      ),
      body: Container(

      ),
    );
  }
}


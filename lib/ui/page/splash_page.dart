import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';

///闪屏页
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

  }

  //初始化
  void _initAsync() async{
    await SpUtil.getInstance();

  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

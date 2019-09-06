import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/common/sp_helper.dart';
import 'package:flutter_start/model/models.dart';
import 'package:flutter_start/util/utils.dart';

///闪屏页
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashPage> {
  //定时器，倒计时用
  TimerUtil _timerUtil;
  List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),
  ];

  //banner
  List<Widget> _bannerList = List();

  SplashModel _splashModel;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  //初始化
  void _initAsync() async {
    await SpUtil.getInstance();
    _loadSplashData();
  }

  void _loadSplashData() {
    _splashModel = SpHelper.getObject<SplashModel>(Constant.key_splash_model);
    if (_splashModel != null) {
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/common/sp_helper.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/util/http_utils.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../baselib/res/colors.dart';
import '../../baselib/util/route_util.dart';

///闪屏页
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashPage> {
  //定时器，倒计时用
  TimerUtil _timerUtil;

  //引导图片本地路径
  List<String> _guidePathList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),
  ];

  //引导页Widget集合
  List<Widget> _guideWidgetList = List();
  SplashModel _splashModel;

  //管理页面状态0=闪屏,1=倒计时，2=引导页
  static const int STATUS_SPLASH = 0;
  static const int STATUS_COUNTDOWN = 1;
  static const int STATUS_GUIDE = 2;
  int _status = STATUS_SPLASH;
  int _count = 3;

  ///splash bg名称
  static const String IMG_SPLASH_BG = 'splash_bg';

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  //初始化
  void _initAsync() async {
    await SpUtil.getInstance();
    _loadSplashData();
    //延迟加载启动页和banner
    Stream.value(1).delay(Duration(milliseconds: 500)).listen((_) {
      //是否加载引导页
      if (SpUtil.getBool(Constant.key_guide, defValue: true) && ObjectUtil.isNotEmpty(_guidePathList)) {
        SpUtil.putBool(Constant.key_guide, false);
        _loadGuideBanner();
      } else {
        _initSplash();
      }
    });
  }

  ///加载启动图
  void _loadSplashData() {
    _splashModel = SpHelper.getObject<SplashModel>(Constant.key_splash_model);
    if (_splashModel != null) {
      setState(() {});
    }
    HttpUtils().getSplash().then((model) {
      if (ObjectUtil.isNotEmpty(model.imgUrl)) {
        if (_splashModel == null || _splashModel.imgUrl != model.imgUrl) {
          SpHelper.putObject(Constant.key_splash_model, model);
          setState(() {
            _splashModel = model;
          });
        }
      } else {
        SpHelper.putObject(Constant.key_splash_model, null);
      }
    });
  }

  void _initSplash() {
    if (_splashModel == null) {
      _goMain();
    } else {
      _performCountDown();
    }
  }

  ///倒计时
  void _performCountDown() {
    setState(() {
      _status = STATUS_COUNTDOWN;
    });
    _timerUtil = TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  ///加载本地引导页
  void _loadGuideBanner() {
    _loadBannerData();
    setState(() {
      _status = STATUS_GUIDE;
    });
  }

  void _loadBannerData() {
    for (int i = 0, length = _guidePathList.length; i < length; i++) {
      if (i < length - 1) {
        _guideWidgetList.add(_buildFullScreenImg(
          _guidePathList[i],
        ));
      } else {
        //最后一页，添加“立即体验”按钮
        _guideWidgetList.add(Stack(
          children: <Widget>[
            _buildFullScreenImg(
              _guidePathList[i],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 120.0),
                child: InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
      }
    }
  }

  void _goMain() {
    RouteUtil.goMain(context);
  }

  ///控制child是否显示
  ///当offstage为true，控件隐藏； 当offstage为false，显示；
  ///当Offstage不可见的时候，如果child有动画等，需要手动停掉，Offstage并不会停掉动画等操作。
  ///const Offstage({ Key key, this.offstage = true, Widget child })

  ///构建全屏幕显示的图片
  Widget _buildFullScreenImg(String imgPath) {
    return Image.asset(
      imgPath,
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }

  ///构建广告
  Widget _buildAdWidget() {
    if (_splashModel == null) {
      return Container(
        height: 0.0,
      );
    }
    return Offstage(
      offstage: !(_status == STATUS_COUNTDOWN),
      child: InkWell(
        onTap: () {
          if (ObjectUtil.isEmpty(_splashModel.url)) {
            return;
          }
          _goMain();
          NavigatorUtils.pushWeb(context, title: _splashModel.title, url: _splashModel.url);
        },
        child: Container(
          alignment: Alignment.center,

          ///带网络缓存的图片加载框架
          child: CachedNetworkImage(
            imageUrl: _splashModel.imgUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) => _buildFullScreenImg(Utils.getImgPath(IMG_SPLASH_BG)),
            errorWidget: (context, url, object) => _buildFullScreenImg(Utils.getImgPath(IMG_SPLASH_BG)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          ///启动图闪屏
          Offstage(
            offstage: !(_status == STATUS_SPLASH),
            child: _buildFullScreenImg(Utils.getImgPath(IMG_SPLASH_BG)),
          ),

          ///引导
          Offstage(
            offstage: !(_status == STATUS_GUIDE),
            child: ObjectUtil.isEmptyList(_guideWidgetList)
                ? Container()
                : Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                        radius: 4.0, padding: EdgeInsets.only(bottom: 16.0), itemColor: Colors.black26),
                    children: _guideWidgetList,
                  ),
          ),
          _buildAdWidget(),

          ///倒计时显示
          Offstage(
            offstage: !(_status == STATUS_COUNTDOWN),
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    IntlUtils.getString(context, Ids.jump_count, params: ['$_count']),
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),

                  ///倒计时按钮背景装饰
                  decoration: BoxDecoration(
                      color: Colours.gray_cc,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(width: 0.5, color: Colours.divider)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    //页面销毁前取消timeUtil
    if (_timerUtil != null) {
      _timerUtil.cancel();
    }
    super.dispose();
  }
}

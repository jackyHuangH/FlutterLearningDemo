import 'package:auto_size/auto_size.dart';
import 'package:base_library/base_library.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_start/bloc/application_bloc.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/common/sp_helper.dart';
import 'package:flutter_start/model/models.dart';
import 'package:flutter_start/national/custom_localization.dart';
import 'package:flutter_start/res/colors.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/ui/page/main_page.dart';
import 'package:flutter_start/ui/page/splash_page.dart';

void main() => runAutoSizeApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider(
        child: MyApp(),
        bloc: MainBloc(),
      ),
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  //国际化
  Locale _locale;

  //主题颜色
  Color _themeColor = Colours.app_main;

  @override
  void initState() {
    super.initState();
    //初始化国际化
    setLocalizedValues(localizedValues);
    _initAsync();
    _initLocalizeListener();
  }

  void _initAsync() async {
    await SpUtil.getInstance();
    if (!mounted) return;
    _initNetUtil();
    _loadLocale();
  }

  ///初始化网络配置
  void _initNetUtil() {
    Options customOption = DioUtil.getDefOptions();
    customOption.baseUrl = Constant.server_address;
    String cookie = SpUtil.getString(BaseConstant.keyAppToken);
    //本地缓存cookie添加到请求头
    if (ObjectUtil.isNotEmpty(cookie)) {
      Map<String, dynamic> _headers = Map();
      _headers['Cookie'] = cookie;
      customOption.headers = _headers;
    }
    DioUtil().setConfig(HttpConfig(options: customOption));
  }

  ///监听用户更改国际化语言设置
  void  _initLocalizeListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      _loadLocale();
    });
  }

  ///加载国际化配置
  void _loadLocale() {
    LanguageModel languageModel = SpHelper.getObject<LanguageModel>(Constant.keyLanguage);
    if (languageModel != null) {
      _locale = Locale(languageModel.languageCode, languageModel.countryCode);
    } else {
      _locale = null;
    }

    //主题色加载
    String _colorKey = SpHelper.getThemeColor();
    if (themeColorMap[_colorKey] != null) {
      _themeColor = themeColorMap[_colorKey];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        BaseConstant.routeMain: (ctx) {
          return MainPage();
        }
      },
      home: SplashPage(),
      theme:
          ThemeData.light().copyWith(primaryColor: _themeColor, accentColor: _themeColor, indicatorColor: Colors.white),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }
}

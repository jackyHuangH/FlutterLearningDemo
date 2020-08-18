import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/application_bloc.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/index.dart';
import 'package:flutter_start/ui/page/language_page.dart';
import 'package:flutter_start/util/navigator_utils.dart';

///设置页面
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    LanguageModel languageModel = SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtils.getString(context, Ids.titleSetting)),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.color_lens),
                Gaps.hGap10,
                Text(
                  IntlUtils.getString(context, Ids.titleTheme),
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
            children: <Widget>[
              Wrap(
                children: themeColorMap.keys.map((String key) {
                  Color colorValue = themeColorMap[key];
                  return InkWell(
                    onTap: () {
                      //点击修改主题颜色
                      SpUtil.putString(Constant.key_theme_color, key);
                      bloc.sendAppEvent(Constant.type_sys_update);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      width: 36.0,
                      height: 36.0,
                      color: colorValue,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          Divider(
            height: 0.3,
            color: Colours.divider,
          ),
          InkWell(
            onTap: () {
              //跳转设置语言
              NavigatorUtils.pushPage(context,
                  page: LanguagePage(), pageName: IntlUtils.getString(context, Ids.titleLanguage));
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.language),
                  Gaps.hGap10,
                  Text(
                    IntlUtils.getString(context, Ids.titleLanguage),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(languageModel == null
                      ? IntlUtils.getString(context, Ids.languageAuto)
                      : IntlUtils.getString(context, languageModel.titleId, languageCode: 'zh', countryCode: 'CH')),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/res/colors.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lpinyin/lpinyin.dart';

class Utils {
  /// 获取图片路径
  static String getImgPath(String name, {String format: 'webp'}) {
    return 'assets/images/$name.$format';
  }

  /// 弹Toast
  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text.isNotEmpty ? text : "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  /// 是否需要登录
  static bool isNeedLogin(String titleId) => titleId == Ids.titleCollection;

  ///根据数据获取刷新状态
  static int getLoadStatus(bool hasError, List data) {
    if (hasError) return LoadStatus.fail;
    if (data == null) {
      return LoadStatus.loading;
    } else if (data.isEmpty) {
      return LoadStatus.empty;
    } else {
      return LoadStatus.success;
    }
  }

  ///获取更新状态
  ///0 不升级
  ///1 升级
  /// x 强制升级
  static int getUpdateStatus(String version, {String local}) {
    if (ObjectUtil.isEmpty(version)) return 0;
    String locVersion = version ?? AppConfig.version;
    int remote = int.tryParse(version.replaceAll(".", ""));
    int locale = int.tryParse(locVersion.replaceAll(".", ""));
    if (remote <= locale) {
      return 0;
    } else {
      return remote - locale;
    }
  }

  ///根据内容动态返回标题字体大小
  static double getTitleFontSize(String title) {
    if (ObjectUtil.isEmpty(title) || title.length < 10) return 18.0;
    //计算中文字符个数
    int count = 0;
    List<String> list = title.split("");
    for (int i = 0, length = list.length; i < length; i++) {
      if (RegexUtil.isZh(list[i])) {
        count++;
      }
    }
    return (count > 10 || title.length > 16) ? 14.0 : 18.0;
  }

  ///日期格式化
  static String getTimeLine(BuildContext context, int timeMillis) {
    return TimelineUtil.format(timeMillis, locale: Localizations
        .localeOf(context)
        .languageCode, dayFormat: DayFormat.Common);
  }

  ///获取汉字拼音首字母大写
  static String getPinyin(String str){
    return PinyinHelper.getShortPinyin(str).substring(0,1).toUpperCase();
  }

  ///根据拼音获取圆形背景颜色
  static Color getCircleBg(String str){
    String pinyin=getPinyin(str);
    return getCircleAvatarBg(pinyin);
  }

  static Color getCircleAvatarBg(String key) {
    return circleAvatarMap[key];
  }

  //根据拼音获取chip背景颜色
  static Color getChipBgColor(String name){
    String pinyin=PinyinHelper.getFirstWordPinyin(name);
    pinyin=pinyin.substring(0,1).toUpperCase();
    return nameToColor(pinyin);
  }

  //随机分配颜色
  static Color nameToColor(String name){
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }
}

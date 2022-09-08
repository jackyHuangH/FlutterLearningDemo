import 'package:flutter/material.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/index.dart';
import 'package:flutter_start/util/utils.dart';

import '../baselib/res/colors.dart';
import '../baselib/res/styles.dart';

///自定义列表头部item
class HeaderItem extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final Color titleColor;
  final IconData leftIcon;
  final String titleId;
  final String title;
  final String extraId;
  final String extra;
  final IconData rightIcon;
  final GestureTapCallback tapCallback;

  const HeaderItem(
      {this.margin,
      this.titleColor,
      this.leftIcon,
      this.titleId: Ids.titleRepos,
      this.title,
      this.extraId: Ids.more,
      this.extra,
      this.rightIcon,
      this.tapCallback,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      margin: margin ?? EdgeInsets.only(top: 0.0),
      child: new ListTile(
        onTap: tapCallback,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(
              leftIcon ?? Icons.whatshot,
              color: titleColor ?? Colors.blueAccent,
            ),
            Gaps.hGap10,
            new Expanded(
                child: new Text(
              title ?? IntlUtils.getString(context, titleId),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: titleColor ?? Colors.blueAccent,
                  fontSize: Utils.getTitleFontSize(title ?? IntlUtils.getString(context, titleId))),
            )),
          ],
        ),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              extra ?? IntlUtils.getString(context, extraId),
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            new Icon(
              rightIcon ?? Icons.keyboard_arrow_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.3, color: Colours.divider))),
    );
  }
}

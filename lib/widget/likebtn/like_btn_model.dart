import 'package:flutter/material.dart';

class LikeIcon extends Icon {
  final Color iconColor;

  const LikeIcon(IconData iconData, {this.iconColor}) : super(iconData);

  @override
  Color get color => this.iconColor;
}

class DotColor {
  final Color dotPrimaryColor;
  final Color dotSecondaryColor;
  final Color dotThirdColor;
  final Color dotLastColor;

  const DotColor({
    @required this.dotPrimaryColor,
    @required this.dotSecondaryColor,
    this.dotThirdColor,
    this.dotLastColor,
  });

  Color get dotThirdColorReal => dotThirdColor ?? dotPrimaryColor;

  Color get dotLastColorReal => dotLastColor ?? dotSecondaryColor;
}

class OverShootCurve extends Curve {
  final double period;

  const OverShootCurve([this.period = 2.5]);

  ///如果assert(false)条件为false.那么就会抛出异常
  //
  //并且,这个玩意只在debug模式下有效.这就更爽了.
  //
  //最后,assert除了传判断条件以外,还可以传一个提示字符串.
  //
  //也就是assert(x==1,'x==1了,报错')
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    t -= 1.0;
    return t * t * ((period + 1) * t + period) + 1.0;
  }

  @override
  String toString() {
    return '$runtimeType{period: $period}';
  }
}

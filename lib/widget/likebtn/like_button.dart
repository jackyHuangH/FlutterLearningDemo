import 'package:flutter/material.dart';
import 'package:flutter_start/widget/likebtn/circle_painter.dart';
import 'package:flutter_start/widget/likebtn/dot_painter.dart';

import 'like_btn_model.dart';

///自定义view ，点赞按钮
///typedef 把这个关键字定义的变量,看成一个接口,大致作用其实就是声明一个匿名函数.
///用typedef用于定义函数类型的别名
typedef LikeCallback = void Function(bool isLike);

class LikeButton extends StatefulWidget {
  final double width;
  final LikeIcon icon;
  final Duration duration;
  final DotColor dotColor;
  final Color circleStartColor;
  final Color circleEndColor;
  final LikeCallback callback;

  const LikeButton(
      {Key key,
      @required this.width,
      this.icon = const LikeIcon(
        Icons.favorite,
        iconColor: Colors.pinkAccent,
      ),
      this.duration = const Duration(milliseconds: 300),
      this.dotColor = const DotColor(
        dotPrimaryColor: const Color(0xFFFFC107),
        dotSecondaryColor: const Color(0xFFFF9800),
        dotThirdColor: const Color(0xFFFF5722),
        dotLastColor: const Color(0xFFF44336),
      ),
      this.circleStartColor = const Color(0xFFFF5722),
      this.circleEndColor = const Color(0xFFFFC107),
      this.callback})
      : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> outerCircle;
  Animation<double> innerCircle;
  Animation<double> dots;
  Animation<double> scale;

  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.duration, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    _initAllAnimation();
  }

  ///初始化所有动画
  void _initAllAnimation() {
    outerCircle = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.3, curve: Curves.ease)));
    innerCircle = Tween<double>(begin: 0.2, end: 1.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Interval(0.2, 0.5, curve: Curves.ease)));
    scale = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: new Interval(0.35, 0.7, curve: OverShootCurve())));
    dots = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: new Interval(0.1, 1.0, curve: Curves.decelerate)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        CustomPaint(
          size: Size(widget.width, widget.width),
          painter: DotPainter(
              currentProgress: dots.value,
              color1: widget.dotColor.dotPrimaryColor,
              color2: widget.dotColor.dotSecondaryColor,
              color3: widget.dotColor.dotThirdColorReal,
              color4: widget.dotColor.dotLastColorReal),
        ),
        CustomPaint(
          size: Size(widget.width * 0.35, widget.width * 0.35),
          painter: CirclePainter(
              outerCircleRadiusProgress: outerCircle.value,
              innerCircleRadiusProgress: innerCircle.value,
              startColor: widget.circleStartColor,
              endColor: widget.circleEndColor),
        ),
        Container(
          width: widget.width,
          height: widget.width,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: _isLiked ? scale.value : 1.0,
            child: GestureDetector(
              child: Icon(
                widget.icon.icon,
                color: _isLiked ? widget.icon.color : Colors.grey,
                size: widget.width * 0.4,
              ),
              onTap: _performTap(),
            ),
          ),
        )
      ],
    );
  }

  ///点赞、取消点赞切换
  _performTap() {
    if (_animationController.isAnimating) {
      return;
    }
    _isLiked = !_isLiked;
    if (_isLiked) {
      _animationController.reset();
      _animationController.forward();
    } else {
      setState(() {});
    }
    if (widget.callback != null) {
      widget.callback(_isLiked);
    }
  }
}

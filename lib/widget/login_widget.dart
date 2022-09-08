import 'package:flutter/material.dart';

import '../baselib/res/colors.dart';
import '../baselib/res/styles.dart';

//自定义组件，登录输入框
class LoginInputItem extends StatefulWidget {
  final IconData prefixIcon;
  final bool hasSuffixIcon;
  final String hintText;
  final TextEditingController controller;

  const LoginInputItem(
      {Key key,
      this.prefixIcon,
      this.hasSuffixIcon = false,
      this.hintText,
      this.controller})
      : super(key: key);

  @override
  _LoginInputItemState createState() => _LoginInputItemState();
}

class _LoginInputItemState extends State<LoginInputItem> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          widget.prefixIcon,
          size: 28.0,
          color: Colors.white,
        ),
        Gaps.hGap10,
        Expanded(
          child: TextField(
            obscureText: _obscureText,
            controller: widget.controller,
            style: TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colours.gray_99, fontSize: 14),
                suffixIcon: widget.hasSuffixIcon
                    ? IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: Colours.gray_f0)),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: Colours.gray_f0))),
          ),
        ),
      ],
    );
  }
}

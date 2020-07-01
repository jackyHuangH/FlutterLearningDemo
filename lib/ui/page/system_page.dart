import 'package:flutter/material.dart';

///系统页面
class SystemPage extends StatefulWidget {
  final String labelId;

  const SystemPage({this.labelId, Key key}) : super(key: key);

  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('系统'),
    );
  }
}

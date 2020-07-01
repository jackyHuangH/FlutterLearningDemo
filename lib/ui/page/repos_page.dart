import 'package:flutter/material.dart';

///项目页面
class ReposPage extends StatefulWidget {
  final String labelId;

  const ReposPage({this.labelId, Key key}) : super(key: key);

  @override
  _ReposPageState createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('项目'),
    );
  }
}

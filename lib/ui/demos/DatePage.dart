import 'package:flutter/material.dart';

///日期选择demo
class DatePage extends StatefulWidget {
  String title;

  DatePage(this.title);

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
    );
  }
}

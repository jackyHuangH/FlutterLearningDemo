import 'package:flutter/material.dart';

///热门页面
class EventsPage extends StatefulWidget {
  final String labelId;

  const EventsPage({this.labelId, Key key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('热门'),);
  }
}

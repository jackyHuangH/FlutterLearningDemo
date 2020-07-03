import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///动态页面
class EventsPage extends StatelessWidget {
  final String labelId;

  const EventsPage({this.labelId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController=new RefreshController();
    MainBloc bloc=BlocProvider.of<MainBloc>(context);


    return StreamBuilder(stream: bloc.eventsStream,
    builder: (BuildContext context,AsyncSnapshot<List<ReposModel>> snapshot){
      //todo 动态列表构建
    },);
  }
}

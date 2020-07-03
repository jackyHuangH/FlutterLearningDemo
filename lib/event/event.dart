import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/application_bloc.dart';
import 'package:flutter_start/bloc/bloc_base.dart';

class Event {
  static void sendAppCommonEvent(BuildContext context, CommonEvent event) {}

  static void sendAppEvent(BuildContext context, int id) {
    BlocProvider.of<ApplicationBloc>(context).sendEvent(id);
  }
}

class CommonEvent {
  int id;
  Object data;

  CommonEvent({this.id, this.data});
}

//状态Event
class StatusEvent {
  String labelId;
  int status;
  int cid;

  StatusEvent(this.labelId, this.status, {this.cid});
}

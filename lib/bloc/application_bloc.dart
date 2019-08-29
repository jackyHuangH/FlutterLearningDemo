import 'dart:async';

import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc implements BlocBase {
  //BehaviorSubject实现了StreamController
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();
  //消息入口
  StreamSink get _appEventSink => _appEvent.sink;
  //消息出口
  Stream get appEventStream => _appEvent.stream;

  @override
  void dispose() {
    _appEvent.close();
  }

  ///发送事件
  void sendEvent(int type) {
    _appEventSink.add(type);
  }

  @override
  Future getData({String labelId, int page}) {
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return null;
  }
}

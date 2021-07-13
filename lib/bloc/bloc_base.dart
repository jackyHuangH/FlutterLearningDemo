import 'dart:async';

import 'package:flutter/material.dart';

//这里我们可以将_MyHomePageState中处理counter自增的逻辑拆分到CounterBloc中
//future(异步函数)里面有几个函数：
//then：异步操作逻辑在这里写。
//whenComplete：异步完成时的回调。
//catchError：捕获异常或者异步出错时的回调。

abstract class BlocBase {
  Future getData({String labelId, int page});

  Future onRefresh({String labelId});

  Future onLoadMore({String labelId});

  void dispose();
}

//但在实际开发当中，一个页面不只有一个bloc，可能有数据处理bloc，事件处理bloc等。
//由此使用一个工具类来管理这些业务逻辑组件显得尤为必要，我们定义个BlocProvider，结构如下

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  final T bloc;
  final bool userDispose;

  BlocProvider(
      {Key key,
      @required this.child,
      @required this.bloc,
      this.userDispose: true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();

  //类静态方法
  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    if (widget.userDispose) {
      widget.bloc.dispose();
    }
    super.dispose();
  }
}

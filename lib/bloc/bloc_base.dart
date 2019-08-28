import 'package:flutter/material.dart';

//这里我们可以将_MyHomePageState中处理counter自增的逻辑拆分到CounterBloc中
abstract class BlocBase {
  void dispose();
}

//但在实际开发当中，一个页面不只有一个bloc，可能有数据处理bloc，事件处理bloc等。
//由此使用一个工具类来管理这些业务逻辑组件显得尤为必要，我们定义个BlocProvider，结构如下

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  final List<T> blocs;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.blocs,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();

  //类静态方法
  static List<T> of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type).widget;
    return provider.blocks;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) => _BlocProviderInherited(
    blocks: widget.blocs,
    child: widget.child,
  );

  @override
  void dispose() {
    widget.blocs.map((bloc) {
      bloc.dispose();
    });
    super.dispose();
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  final List<T> blocks;

  _BlocProviderInherited(
      {Key key, @required this.blocks, @required Widget child})
      : super(child: child, key: key);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
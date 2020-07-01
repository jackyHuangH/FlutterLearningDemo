import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/widget/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//typedef关键字，用来声明一种类型，当一个函数类型分配给一个变量时，保留类型信息。
//其实可以把这个关键字定义的变量,看成一个接口
typedef OnRefreshCallback = Future<void> Function({bool isReload});
typedef OnLoadMore(bool up);

//自定义下拉刷新组件
class RefreshScaffold extends StatefulWidget {
  final String labelId;
  final int loadStatus;
  final RefreshController refreshController;
  final bool enablePullUp;
  final OnRefreshCallback onRefresh;
  final OnLoadMore onLoadMore;
  final Widget child;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const RefreshScaffold(
      {Key key,
      this.labelId,
      this.loadStatus,
      this.refreshController,
      this.enablePullUp,
      this.onRefresh,
      this.onLoadMore,
      this.child,
      this.itemCount,
      this.itemBuilder})
      : super(key: key);

  @override
  _RefreshScaffoldState createState() => _RefreshScaffoldState();
}

//AutomaticKeepAliveClientMixin 使组件保持状态不会被销毁
class _RefreshScaffoldState extends State<RefreshScaffold> with AutomaticKeepAliveClientMixin {
  //是否展示悬浮按钮
  bool isShowFloatBtn = false;

  @override
  void initState() {
    super.initState();
//    监听判断元素渲染完成，这个方法在一帧的最后调用，并且只调用一次。
//使用这个方法就可以在判断渲染完成，并获取到元素的大小
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.refreshController.scrollController.addListener(() {
        //获取滑动偏移量
        int offset = widget.refreshController.scrollController.offset.toInt();
        LogUtil.e("offset:$offset");
        if (offset < 480 && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else if (offset > 480 && !isShowFloatBtn) {
          isShowFloatBtn = true;
          setState(() {});
        }
      });
    });
  }

  Widget _buildFloatingActionButton() {
    if (widget.refreshController.scrollController == null || widget.refreshController.scrollController.offset < 480) {
      return null;
    }

    return new FloatingActionButton(
      onPressed: () {
        //点击回到顶部
        widget.refreshController.scrollController
            .animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
      heroTag: widget.labelId,
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.keyboard_arrow_up),
    );
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context);必须添加，保持状态不被销毁
    super.build(context);
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new RefreshIndicator(
              child: new SmartRefresher(
                controller: widget.refreshController,
                enableOverScroll: false,
                enablePullDown: false,
                enablePullUp: widget.enablePullUp,
                onRefresh: widget.onLoadMore,
                child: widget.child ??
                    new ListView.builder(
                      itemBuilder: widget.itemBuilder,
                      itemCount: widget.itemCount,
                    ),
              ),
              onRefresh: widget.onRefresh),
          new StatusView(
            widget.loadStatus,
            tapCallback: () {
              widget.onRefresh(isReload: true);
            },
          )
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

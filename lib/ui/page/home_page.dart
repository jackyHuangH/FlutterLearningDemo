import 'package:base_library/base_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/article_item.dart';
import 'package:flutter_start/widget/head_item.dart';
import 'package:flutter_start/widget/refresh_scaffold.dart';
import 'package:flutter_start/widget/repos_item.dart';
import 'package:flutter_start/widget/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

///主页
///Flutter提供了名为StreamBuilder的类，它监听Stream，并且在Stream数据流出时会自动重新构建widget，通过其builder进行回调。
///首页只初始化一次
bool isHomeInit = false;

class HomePage extends StatelessWidget {
  final String labelId;

  const HomePage({Key key, this.labelId}) : super(key: key);

  //构建banner
  Widget buildBanner(BuildContext context, List<BannerModel> bannerList) {
    if (ObjectUtil.isEmpty(bannerList)) {
      //列表为空
      return Container(height: 0.0);
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.bottomEnd,
        circular: true,
        interval: const Duration(seconds: 3),
        indicator: NumberSwipeIndicator(),
        children: bannerList.map((item) {
          return SafeArea(
            child: new InkWell(
              onTap: () {
                //banner点击
                NavigatorUtils.pushWeb(context, title: item.title, url: item.url);
              },
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: item.imagePath,
                placeholder: (context, url) => ProgressView(),
                errorWidget: (context, url, obj) => Icon(Icons.error),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  //构建文章列表
  Widget buildRepos(BuildContext context, List<ReposModel> reposList) {
    if (ObjectUtil.isEmpty(reposList)) {
      return Container(
        height: 0.0,
      );
    }
    //文章列表
    List<Widget> _itemList = reposList.map((model) {
      return new ReposItem(
        model,
        isHome: true,
      );
    }).toList();
    List<Widget> children = new List();
    //文章列表头
    children.add(new HeaderItem(
      leftIcon: Icons.book,
      titleId: Ids.recRepos,
      tapCallback: () {
        //跳转项目tab页面
        NavigatorUtils.pushTabPage(context, labelId: Ids.titleReposTree, titleId: Ids.titleReposTree);
      },
    ));
    children.addAll(_itemList);
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  //构建微信文章列表
  Widget buildWxArticles(BuildContext context, List<ReposModel> reposList) {
    if (ObjectUtil.isEmpty(reposList)) {
      return Container(
        height: 0.0,
      );
    }
    List<Widget> _articleList = reposList
        .map((model) => new ArticleItem(
              model,
              isHome: true,
            ))
        .toList();
    List<Widget> children = new List();
    children.add(new HeaderItem(
      titleColor: Colors.green,
      leftIcon: Icons.library_books,
      titleId: Ids.recWxArticle,
      tapCallback: () {
        //跳转微信文章tab页面
        NavigatorUtils.pushTabPage(context, labelId: Ids.titleWxArticleTree, titleId: Ids.titleWxArticleTree);
      },
    ));
    children.addAll(_articleList);
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = BlocProvider.of<MainBloc>(context);
    RefreshController _controller = new RefreshController();
    //加载数据
    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _controller.sendBack(false, event.status);
      }
    });
    if (isHomeInit == false) {
      LogUtil.e("HomePage init......");
      //初始化首页数据
      isHomeInit = true;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((event) {
        bloc.onRefresh(labelId: labelId);
        bloc.getHotRecItem();
      });
    }

    return StreamBuilder(
      stream: bloc.bannerStream,
      builder: (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot) {
        //下拉刷新控件
        return new RefreshScaffold(
          labelId: labelId,
          loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
          refreshController: _controller,
          enablePullUp: false,
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId);
          },
          child: new ListView(
            children: <Widget>[
              new StreamBuilder(
                  stream: bloc.recItemStream,
                  builder: (BuildContext context, AsyncSnapshot<ComModel> snapshot) {
                    ComModel hotRecModel = bloc.hotRecModel;
                    if (hotRecModel == null) {
                      return Container(
                        height: 0.0,
                      );
                    }
                    int updateStatus = Utils.getUpdateStatus(hotRecModel.version);
                    return new HeaderItem(
                      titleColor: Colors.redAccent,
                      title: updateStatus == 0 ? hotRecModel.content : hotRecModel.title,
                      extra: updateStatus == 0 ? 'Go' : '',
                      tapCallback: () {
                        if (updateStatus == 0) {
                          //todo 跳转热门页面
//                        NavigatorUtils.pushPage(context, page: null)
                        } else {
                          NavigatorUtils.launchInBrowser(hotRecModel.url, title: hotRecModel.title);
                        }
                      },
                    );
                  }),
              buildBanner(context, snapshot.data),
              new StreamBuilder(
                  stream: bloc.recReposStream,
                  builder: (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
                    return buildRepos(context, snapshot.data);
                  }),
              new StreamBuilder(
                  stream: bloc.recWxArticleStream,
                  builder: (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
                    return buildWxArticles(context, snapshot.data);
                  })
            ],
          ),
        );
      },
    );
  }
}

///数字指示器
class NumberSwipeIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      child: Text(
        "${++index}/$itemCount",
        style: TextStyle(color: Colors.white70, fontSize: 11.0),
      ),
    );
  }
}

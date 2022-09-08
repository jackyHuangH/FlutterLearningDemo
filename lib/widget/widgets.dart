import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/ui/page/user/user_login_page.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/util/utils.dart';

import '../baselib/common/common.dart';
import '../baselib/res/colors.dart';
import '../baselib/res/styles.dart';
import '../baselib/util/commonkit.dart';

///自定义加载view
class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

///自定义状态切换view
class StatusView extends StatelessWidget {
  final int status;
  final GestureTapCallback tapCallback;

  const StatusView(this.status, {Key key, this.tapCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.fail:
        return Container(
          width: double.infinity,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                tapCallback();
              },
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Utils.getImgPath("ic_network_error"),
                    width: 100,
                    height: 100,
                  ),
                  Gaps.vGap10,
                  Text(
                    "网络错误，请检查你的网络设置",
                    style: TextStyles.listContent,
                  ),
                  Gaps.vGap5,
                  Text(
                    "点击重新加载",
                    style: TextStyles.listContent,
                  )
                ],
              ),
            ),
          ),
        );
        break;
      case LoadStatus.loading:
        return new Container(
          alignment: Alignment.center,
          color: Colours.gray_f0,
          child: ProgressView(),
        );
        break;
      case LoadStatus.empty:
        return new Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Utils.getImgPath('ic_data_empty'),
                width: 60,
                height: 60,
              ),
              Gaps.vGap10,
              Text(
                '空空如也~',
                style: TextStyles.listContent2,
              )
            ],
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }
}

///自定义点赞按钮，无动画
class LikeBtn extends StatelessWidget {
  final String labelId;
  final int id;
  final bool isLike;

  LikeBtn({this.labelId, this.id, this.isLike, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return InkWell(
      onTap: () {
        if (CommonKit.isLogin()) {
          //收藏,取消收藏
          bloc.doCollect(id, !isLike);
        } else {
          //未登录，跳转登录页
          NavigatorUtils.pushPage(context, page: UserLoginPage(), pageName: "UserLoginPage");
        }
      },
      child: new Icon(
        Icons.favorite,
        color: (CommonKit.isLogin() && isLike == true) ? Colors.redAccent : Colors.grey,
      ),
    );
  }
}

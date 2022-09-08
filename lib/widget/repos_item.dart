import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/widgets.dart';

import '../baselib/res/colors.dart';
import '../baselib/res/styles.dart';

///列表item封装
class ReposItem extends StatelessWidget {
  final String labelId;
  final ReposModel model;
  final bool isHome;

  const ReposItem(this.model, {this.labelId, this.isHome, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: new InkWell(
        onTap: () {
          //点击跳转文章详情
          NavigatorUtils.pushWeb(context, title: model.title, url: model.link, isHome: isHome);
        },
        child: new Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
          height: 160.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      model.title,
                      style: TextStyles.listTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap10,
                    new Text(
                      model.desc,
                      style: TextStyles.listContent,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap5,
                    new Row(
                      children: <Widget>[
                        new LikeBtn(
                          labelId: labelId,
                          id: model.originId ?? model.id,
                          isLike: model.collect,
                        ),
                        Gaps.hGap10,
                        new Text(
                          model.author,
                          style: TextStyles.listExtra,
                        ),
                        Gaps.hGap10,
                        new Text(
                          Utils.getTimeLine(context, model.publishTime),
                          style: TextStyles.listExtra,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 72,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10.0),
                /*child: FadeInImage.assetNetwork(placeholder: "images/pic_def.png", image: model.envelopePic),*/
                child: new CachedNetworkImage(
                  imageUrl: model.envelopePic,
                  height: 128.0,
                  fit: BoxFit.fill,
                  width: 72.0,
                  placeholder: (BuildContext context, String url) => new ProgressView(),
                  errorWidget: (BuildContext context, String url, Object o) => new Icon(
                    Icons.error,
                    color: Colors.deepOrange,
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colours.divider, width: 0.5))),
        ),
      ),
    );
  }
}

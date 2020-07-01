import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/widgets.dart';

///微信文章列表item
class ArticleItem extends StatelessWidget {
  final String labelId;
  final ReposModel model;
  final bool isHome;

  const ArticleItem(this.model, {this.labelId, this.isHome, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          //todo 跳转文章详情
        },
        child: Container(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 10.0),
          child: new Row(
            children: <Widget>[
              Expanded(
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
              new Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 12.0),
                child: CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Utils.getCircleBg(model.superChapterName ?? "公众号"),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new Text(
                        model.superChapterName ?? "文章",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 11.0),
                      ),
                    )),
              )
            ],
          ),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colours.divider))),
        ),
      ),
    );
  }
}

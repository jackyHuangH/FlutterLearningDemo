import 'package:flutter/material.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/res/index.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/util/utils.dart';

import '../baselib/res/colors.dart';
import '../baselib/res/styles.dart';

//树形列表item
class TreeItem extends StatelessWidget {
  final TreeModel model;

  const TreeItem(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> chips = model.children
        .map((TreeModel _treeModel) => Chip(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              key: ValueKey<String>(_treeModel.name),
              backgroundColor: Utils.getChipBgColor(_treeModel.name),
              label: Text(
                _treeModel.name,
                style: TextStyle(fontSize: 14.0),
              ),
            ))
        .toList();

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // 跳转tab页,这里的文章没有分页
          NavigatorUtils.pushTabPage(context,
              labelId: Ids.titleSystemTree, title: model.name, treeModel: model, enablePullUp: false);
        },
        child: new _ChipTile(model.name, chips),
      ),
    );
  }
}

//标签列表 item Wraps a list of chips into a ListTile for display as a section in the demo.
class _ChipTile extends StatelessWidget {
  final String label; //section name
  final List<Widget> children;

  const _ChipTile(this.label, this.children, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> cardChildren = <Widget>[
      Text(
        label,
        style: TextStyles.listTitle,
      ),
      Gaps.vGap10
    ];
    cardChildren.add(Wrap(
      children: children
          .map((Widget chip) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: chip,
              ))
          .toList(),
    ));

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colours.divider))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/widget/likebtn/like_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../baselib/res/colors.dart';
import '../baselib/res/styles.dart';

///webView构建
class WebScaffold extends StatefulWidget {
  final String title;
  final String titleId;
  final String url;

  WebScaffold({Key key, this.title, this.titleId, this.url}) : super(key: key);

  @override
  _WebScaffoldState createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  void _onPopSelected(String value) {
    String _title = widget.title ?? IntlUtils.getString(context, widget.titleId);
    switch (value) {
      case "browser":
        NavigatorUtils.launchInBrowser(widget.url, title: _title);
        break;
      case "share":
        //分享
        share();
        break;
      case "collection":
        break;
      default:
        break;
    }
  }

  //普通分享
  Future<void> share() async {
    String _title = widget.title ?? IntlUtils.getString(context, widget.titleId);
    await FlutterShare.share(
        title: _title,
        text: 'Example share text',
        linkUrl: widget.url,
        chooserTitle: 'Example Chooser Title'
    );
  }

  //分享文件，仅供参考 需要引入 https://pub.flutter-io.cn/packages/documents_picker
  // Future<void> shareFile() async {
  //   List<dynamic> docs = await DocumentsPicker.pickDocuments;
  //   if (docs == null || docs.isEmpty) return null;
  //
  //   await FlutterShare.shareFile(
  //     title: 'Example share',
  //     text: 'Example share text',
  //     filePath: docs[0] as String,
  //   );
  // }

  ///获取弹窗菜单menuItem
  PopupMenuItem<String> _getPopupMenuItem(String text, IconData iconData) => PopupMenuItem<String>(
        value: 'browser',
        child: ListTile(
          contentPadding: EdgeInsets.all(0.0),
          dense: false,
          title: Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colours.gray_66,
                  size: 22.0,
                ),
                Gaps.hGap10,
                Text(
                  text,
                  style: TextStyles.listContent,
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? IntlUtils.getString(context, widget.titleId),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: <Widget>[
          LikeButton(
            width: 56.0,
            duration: Duration(milliseconds: 500),
          ),
          PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelected,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    _getPopupMenuItem('浏览器打开', Icons.language),
                    _getPopupMenuItem('分享', Icons.share)
                  ]),
        ],
      ),
      body: WebView(
        onWebViewCreated: (WebViewController controller) {},
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

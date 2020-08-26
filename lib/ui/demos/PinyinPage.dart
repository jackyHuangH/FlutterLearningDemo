import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';

class PinyinTypeModel {
  String name;
  int type;
  bool isSelect;

  PinyinTypeModel(this.name, this.type, this.isSelect);
}

///拼音demo
class PinyinPage extends StatefulWidget {
  String title;

  PinyinPage(this.title);

  @override
  _PinyinPageState createState() => _PinyinPageState();
}

class _PinyinPageState extends State<PinyinPage> {
  List<PinyinTypeModel> _typeList = new List();
  final textEditController = new TextEditingController();
  WidgetUtil _widgetUtil = WidgetUtil();

  static const int TYPE_PINYIN_WITH_TONE = 1;
  static const int TYPE_PINYIN_WITHOUT_TONE = 2;
  static const int TYPE_PINYIN_WITH_NUMBER_TONE = 3;
  static const int TYPE_SIMPLIFIED = 4;
  static const int TYPE_TRADITIONAL = 5;

  String inputText = "永远的女神 坂井泉水";
  String _resultText = "";
  PinyinTypeModel _currentModel;

  ///工具转换后的字符

  @override
  void initState() {
    super.initState();
    _typeList.add(PinyinTypeModel("带声调", TYPE_PINYIN_WITH_TONE, true));
    _typeList.add(PinyinTypeModel("不带声调", TYPE_PINYIN_WITHOUT_TONE, false));
    _typeList.add(PinyinTypeModel("带数字声调", TYPE_PINYIN_WITH_NUMBER_TONE, false));
    _typeList.add(PinyinTypeModel("繁->简", TYPE_SIMPLIFIED, false));
    _typeList.add(PinyinTypeModel("简->繁", TYPE_TRADITIONAL, false));
    //默认第一类
    _currentModel = _typeList[0];
  }

  void _updateSelectState(PinyinTypeModel model) {
    _typeList.forEach((element) {
      element.isSelect = (element.name == model.name);
      _currentModel = model;
      _updateText(inputText);
    });
  }

  ///更新显示结果
  void _updateText(String newText) {
    inputText = newText;
    if (newText.isEmpty) {
      setState(() {
        _resultText = "";
      });
    } else {
      setState(() {
        _convertPinyin(newText);
      });
    }
  }

  ///转换拼音或者字体
  void _convertPinyin(String text) {
    switch (_currentModel.type) {
      case TYPE_PINYIN_WITH_TONE:
        _resultText = PinyinHelper.getPinyin(text, format: PinyinFormat.WITH_TONE_MARK);
        break;
      case TYPE_PINYIN_WITHOUT_TONE:
        _resultText = PinyinHelper.getPinyin(text, format: PinyinFormat.WITHOUT_TONE);
        break;
      case TYPE_PINYIN_WITH_NUMBER_TONE:
        _resultText = PinyinHelper.getPinyin(text, format: PinyinFormat.WITH_TONE_NUMBER);
        break;
      case TYPE_SIMPLIFIED:
        _resultText = ChineseHelper.convertToSimplifiedChinese(text);
        break;
      case TYPE_TRADITIONAL:
        _resultText = ChineseHelper.convertToTraditionalChinese(text);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //只初始化一次渲染
    _widgetUtil.asyncPrepare(context, true, (Rect rect) {
      textEditController.text = inputText;
      _updateText(inputText);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5, color: Colours.divider),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [BoxShadow(offset: Offset(0.0, 2.0), blurRadius: 5.0, spreadRadius: 1.0)]),
            child: Column(
              children: <Widget>[
                Row(
                  children: _typeList.map((PinyinTypeModel model) {
                    return Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            model.name,
                            style: TextStyle(fontSize: 13.0),
                          ),
                          Radio(
                            value: true,
                            groupValue: model.isSelect == true,
                            onChanged: (bool value) {
                              setState(() {
                                _updateSelectState(model);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                TextField(
                  controller: textEditController,
                  onChanged: (String s) {
                    _updateText(s);
                  },
                ),
                Gaps.vGap5,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$_resultText',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}

import 'package:flutter/material.dart';

class PinyinTypeModel {
  String name;
  String value;
  bool isSelect;

  PinyinTypeModel(this.name, this.value, this.isSelect);
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

  @override
  void initState() {
    super.initState();
    _typeList.add(PinyinTypeModel("带声调", "1", true));
    _typeList.add(PinyinTypeModel("不带声调", "2", false));
    _typeList.add(PinyinTypeModel("带数字声调", "3", false));
    _typeList.add(PinyinTypeModel("繁->简", "4", false));
    _typeList.add(PinyinTypeModel("简->繁", "5", false));
  }

  @override
  Widget build(BuildContext context) {
    void _updateSelectState(PinyinTypeModel model) {
      _typeList.forEach((element) {
        element.isSelect = (element.name == model.name);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
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
          )
        ],
      ),
    );
  }
}

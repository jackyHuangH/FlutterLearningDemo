import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:lpinyin/lpinyin.dart';

class CityModel extends ISuspensionBean {
  String name;
  String namePinyin;
  String tagIndex;

  CityModel({this.name, this.namePinyin, this.tagIndex});

  CityModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
    };
  }

  @override
  String toString() => json.encode(this);

  @override
  String getSuspensionTag() => this.tagIndex;
}

///城市选择demo
class CitySelectPage extends StatefulWidget {
  String title;

  CitySelectPage(this.title);

  @override
  _CitySelectPageState createState() => _CitySelectPageState();
}

class _CitySelectPageState extends State<CitySelectPage> {
  List<CityModel> cityList = new List();
  List<CityModel> _hotCityList = new List();
  String _currentCity = '杭州';

  @override
  void initState() {
    super.initState();
    _hotCityList.add(new CityModel(name: '北京', tagIndex: '★'));
    _hotCityList.add(new CityModel(name: '上海', tagIndex: '★'));
    _hotCityList.add(new CityModel(name: '广州', tagIndex: '★'));
    _hotCityList.add(new CityModel(name: '深圳', tagIndex: '★'));
    _hotCityList.add(new CityModel(name: '天津', tagIndex: '★'));
    _hotCityList.add(new CityModel(name: '武汉', tagIndex: '★'));
    _hotCityList.add(new CityModel(name: '杭州', tagIndex: '★'));
    cityList.addAll(_hotCityList);

    SuspensionUtil.setShowSuspensionStatus(cityList);
    //子线程请求city数据
    Future.delayed(new Duration(milliseconds: 100), () {
      loadData();
    });
  }

  void loadData() async {
    //加载本地city数据
    rootBundle.loadString('assets/data/china.json').then((value) {
      cityList.clear();
      Map countryMap = json.decode(value);
      List list = countryMap['china'];
      list.forEach((v) {
        cityList.add(CityModel.fromJson(v));
      });
      _handleCity(cityList);
    });
  }

  void _handleCity(List<CityModel> list) {
    if (list == null || list.isEmpty) return;
    for (var item in list) {
      String pinyin = PinyinHelper.getPinyinE(item.name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      item.namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        item.tagIndex = tag;
      } else {
        item.tagIndex = "#";
      }
    }
    //sort city by A-Z
    SuspensionUtil.sortListBySuspensionTag(list);
    //add hot city
    list.insertAll(0, _hotCityList);
    SuspensionUtil.setShowSuspensionStatus(list);
    //update ui
    setState(() {});
  }

  Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
    if ("★" == tag) {
      tag = "★ 热门城市";
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(fontSize: 14.0, color: Color(0xFF999999)),
      ),
    );
  }

  Widget getListItem(BuildContext context, CityModel model,
      {double susHeight = 40}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          title: Text(model.name),
          onTap: () {
            Utils.showToast(model.name);
            setState(() {
              _currentCity = model.name;
            });
          },
        )
      ],
    );
  }

  Widget getHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 45.0,
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textInputAction: TextInputAction.search,
            onEditingComplete: () {
              Utils.showToast("暂时无操作哦");
            },
            style: TextStyle(fontSize: 14.0, color: Color(0xFF282828)),
            autofocus: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
                border: InputBorder.none,
                hintText: "请输入城市名",
                hintStyle: TextStyle(fontSize: 14.0, color: Color(0xFF999999)),
                labelStyle:
                    TextStyle(fontSize: 14.0, color: Color(0xFFCCCCCC))),
          )),
          Gaps.hGap5,
          Material(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "取消",
                  style: TextStyle(fontSize: 14.0, color: Colors.blueAccent),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          getHeader(context),
          Expanded(
            child: Material(
              color: Colors.black45,
              child: Card(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0))),
                child: Column(
                  children: [
                    Container(
                      height: 45.0,
                      padding: EdgeInsets.only(left: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Text("当前城市：$_currentCity"),
                    ),
                    Expanded(
                      child: AzListView(
                        data: cityList,
                        itemCount: cityList.length,
                        itemBuilder: (BuildContext context, int index) {
                          CityModel model = cityList[index];
                          return getListItem(context, model);
                        },
                        susItemBuilder: (BuildContext context, int index) {
                          CityModel model = cityList[index];
                          String tag = model.getSuspensionTag();
                          return getSusItem(context, tag);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

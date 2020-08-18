import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/application_bloc.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/index.dart';

///语言设置页面
class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  List<LanguageModel> _languageList = new List();
  LanguageModel _currentLanguageModel;

  @override
  void initState() {
    super.initState();
    _languageList.add(LanguageModel(Ids.languageAuto, '', ''));
    _languageList.add(LanguageModel(Ids.languageZH, 'zh', 'CH'));
    _languageList.add(LanguageModel(Ids.languageTW, 'zh', 'TW'));
    _languageList.add(LanguageModel(Ids.languageHK, 'zh', 'HK'));
    _languageList.add(LanguageModel(Ids.languageEN, 'en', 'US'));

    _currentLanguageModel = SpUtil.getObj(Constant.keyLanguage, (json) => LanguageModel.fromJson(json));
    if (ObjectUtil.isEmpty(_currentLanguageModel)) {
      _currentLanguageModel = _languageList[0];
    }

    _updateLanguage();
  }

  ///更新语言设置,是否选中
  void _updateLanguage() {
    _languageList.forEach((model) {
      model.isSelected = (model.countryCode == _currentLanguageModel.countryCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    ApplicationBloc _bloc = BlocProvider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtils.getString(context, Ids.titleLanguage)),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              onPressed: () {
                //保存语言设置并生效
                SpUtil.putObject(Constant.keyLanguage,
                    ObjectUtil.isEmpty(_currentLanguageModel.languageCode) ? null : _currentLanguageModel);
                _bloc.sendAppEvent(Constant.type_sys_update);
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              color: Colors.blueAccent,
              child: Text(
                IntlUtils.getString(context, Ids.save),
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: _languageList.map((LanguageModel model) {
          return Column(
            children: <Widget>[
              Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentLanguageModel = model;
                      _updateLanguage();
                    });
                  },
                  child: RadioListTile<bool>(
                    value: true,
                    groupValue: model.isSelected == true,
                    title: Text(
                      model.titleId == Ids.languageAuto
                          ? IntlUtils.getString(context, model.titleId)
                          : IntlUtils.getString(context, model.titleId, languageCode: 'zh', countryCode: 'CH'),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    selected: true,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        _currentLanguageModel = model;
                        _updateLanguage();
                      });
                    },
                  ),

                  ///经研究发现，groupValue可以代表组的值，只是需要与value进行对比，
                  ///如果value值与groupValue值相同，则处于选中状态，否则为不选中状态
                ),
              ),
              Divider(
                height: 0.3,
                color: Colours.divider,
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

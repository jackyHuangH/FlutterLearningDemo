import 'package:flutter/material.dart';
import 'package:flutter_start/util/utils.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索"),
      ),
      body: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          "后续加上。。。",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.showToast("搜索暂未实现哦~");
        },
        child: Icon(Icons.search),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

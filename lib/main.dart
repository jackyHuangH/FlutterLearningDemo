import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(new HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Welcome to Flutter",
        home: new Scaffold(body: new RandomWords()));
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  //定义一个空的集合
  final _suggestion = <WordPair>[];

  //const 定义常量
  final _biggerFontStyle = const TextStyle(fontSize: 18.0);

  //set保存用户收藏的单词
  final _likes = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("开始记单词啦！"),
        //增加菜单按钮
        actions: <Widget>[
          //没有返回值的函数调用时不能加（）
          new IconButton(icon: new Icon(Icons.list), onPressed: _gotoSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  ///跳转到我的收藏页面
  void _gotoSaved() {
    //添加Navigator.push调用，这会使路由入栈（以后路由入栈均指推入到导航管理器的栈）
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _likes.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asCamelCase,
            style: _biggerFontStyle,
          ),
        );
      });
      //ListTile的divideTiles()方法在每个ListTile之间添加1像素的分割线。 该 divided 变量持有最终的列表项。
      final divides = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      //返回界面元素
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("我的收藏"),
        ),
        body: new ListView(
          children: divides,
        ),
      );
    }));
  }

  /// 定义生成列表函数
  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider(height: 1.0, color: Colors.grey);
          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对item位置
          final index = i ~/ 2;
          //当index为列表最后一项时，再生成一组数据，类似于分页加载更多
          if (index >= _suggestion.length) {
            //继续添加数据
            _suggestion.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestion[index]);
        });
  }

  /// 生成列表item函数
  Widget _buildRow(WordPair pair) {
    //判断单词是否已在收藏夹
    final hasLiked = _likes.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asCamelCase,
        style: _biggerFontStyle,
      ),
      trailing: new Icon(
        hasLiked ? Icons.favorite : Icons.favorite_border,
        color: hasLiked ? Colors.red : null,
      ),
      //定义点击事件,函数调用setState()通知框架状态已经改变
      onTap: () {
        setState(() {
          if (hasLiked) {
            _likes.remove(pair);
          } else {
            _likes.add(pair);
          }
        });
      },
    );
  }
}

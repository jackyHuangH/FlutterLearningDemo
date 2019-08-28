import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bloc/bloc_base.dart';

void main() => runApp(new HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Welcome to Flutter",
      //修改主题
      theme: new ThemeData(primaryColor: Colors.white),
//        home: new Scaffold(body: new RandomWords())
//      home: new Scaffold(
////        body: MyAnimateTest(),
////        body: LoadDataTest(),
////        body: Signature(),
////        body: SampleAppPage(),
////        body: MyBlocPage("bloc Test"),
//      ),
      home:
          BlocProvider(child: MyBlocPage("bloc test"), blocs: [CounterBloc()]),
    );
  }
}

//--------------------------------bloc设计模式,感觉有点像LiveData-------------------------------

class MyBlocPage extends StatefulWidget {
  MyBlocPage(this.title);

  final String title;

  @override
  State<StatefulWidget> createState() => MyBlocState();
}

class MyBlocState extends State<MyBlocPage> {
  int _counter = 0;

  void _incrementCounter() {
    BlocProvider.of<CounterBloc>(context).first.increment(_counter);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CounterBloc>(context).first.counterStream.listen((_count) {
      setState(() {
        _counter = _count;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("you have pushed the button this many times:"),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterBloc extends BlocBase {
  final _controller = StreamController<int>();

  //数据入口
  StreamSink<int> get _counterSink => _controller.sink;

  //数据出口
  Stream<int> get counterStream => _controller.stream;

  void increment(int count) {
    _counterSink.add(++count);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

//-------------------------------如何将任务转移到后台线程--------------------------------------

//在 Flutter 中，可以通过使用 Isolate 来利用多核处理器的优势执行耗时或计算密集的任务。
//Isolate 是独立执行的线程，不会和主执行内存堆分享内存。这意味着你无法访问主线程的变量，或者调用 setState() 更新 UI。
// 不同于 Android 中的线程，Isolate 如其名所示，它们无法分享内存（例如通过静态变量的形式）。
//下面的例子展示了一个简单的 Isolate 是如何将数据分享给主线程来更新 UI 的。
class SampleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SamplePageState();
}

class SamplePageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  //是否显示加载中
  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }
    return false;
  }

  getProgressDialog() => Center(
        child: CircularProgressIndicator(),
      );

  /**
   * 切换页面状态，加载中和内容
   */
  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("sample App")),
      body: getBody(),
    );
  }

  getListView() => ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int index) {
        return getRow(index);
      });

  getRow(int index) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text("Row ${widgets[index]["title"]}"),
    );
  }

  //
  loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    // The 'echo' isolate sends its SendPort as the first message
    SendPort sendPort = await receivePort.first;
    List msg = await sendReceive(
        sendPort, "https://jsonplaceholder.typicode.com/posts");
    setState(() {
      widgets = msg;
    });
  }

  // the entry point for the isolate
  static dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort receivePort = ReceivePort();
    // Notify any other isolates what port this isolate listens to.
    sendPort.send(receivePort.sendPort);
    await for (var msg in receivePort) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataUrl = data;
      http.Response response = await http.get(dataUrl);
      // Lots of JSON to parse
      replyTo.send(json.decode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}

//---------------------列表测试------------------------------------------
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
  String title = "我爱记单词";

  ///更新标题
  void _updateTitle() {
    setState(() {
      title = "学习，学个屁啊！";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        //增加菜单按钮
        actions: <Widget>[
          //没有返回值的函数调用时不能加（）
          new IconButton(icon: new Icon(Icons.list), onPressed: _gotoSaved)
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _updateTitle,
        child: new Icon(Icons.update),
      ),
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

//------------------------动画练习-------------------------------------
class MyAnimateTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyFadeState();
}

class _MyFadeState extends State<MyAnimateTest> with TickerProviderStateMixin {
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画练习"),
      ),
      body: Center(
        child: GestureDetector(
          child: RotationTransition(
            turns: _curvedAnimation,
            child: FlutterLogo(
              size: 100.0,
            ),
          ),
          onDoubleTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "fade",
        child: Icon(Icons.brush),
        onPressed: () {
          _animationController.forward();
        },
      ),
    );
  }
}

//-------------------------异步加载数据--------------------------------
class LoadDataTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoadDataState();
}

class LoadDataState extends State<LoadDataTest> {
  List widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("加载数据"),
      ),
      body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int index) {
            return _getRow(index);
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "load data",
        child: Icon(Icons.file_download),
        onPressed: loadData,
      ),
    );
  }

  Widget _getRow(int position) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row ${widgets[position]["title"]}"));
  }

  //网络数据获取,异步方式,类似于kotlin协程写法
  loadData() async {
    String dataUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataUrl);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}

//------------------自定义绘制，签名-------------------------------------
class Signature extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  //存储点
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) {
        _points.add(null);
      },
      child: CustomPaint(
        painter: SignaturePainter(_points),
        size: Size.infinite,
      ),
    );
  }
}

///自定义画笔
class SignaturePainter extends CustomPainter {
  final List<Offset> points;

  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    /* // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);*/

    //----------------------dart语法学习-----------------------------
    //数字类型 int，double
    int a = 1;
    print(a);

    double b = 1.12;
    print(b);

    //string转double
    final result = double.parse('1.1');
    print(result);

    String s = '';
    assert(s.isEmpty);

    //List集合,未指定数据类型时默认为object,在Dart中，数组是List对象
    List list = [1, 2, 3, 4, '你好'];
    print(list);
    // 使用List的构造函数，也可以添加int参数，表示List固定长度，不能进行添加 删除操作
    List<String> food = new List();
    food.add('rice');
    food.add('apple');
    //添加多个元素
    food.addAll(['orange', 'milk', 'chocolate']);
    print(food);

    //集合遍历
    for (var value in food) {
      print(value);
    }
    for (int i = 0; i < food.length; i++) {
      print(food[i]);
    }
    food.forEach((f) => print(f));

    //Map 集合
    final Map<String, String> company = {
      'ali': "阿里巴巴",
      "tencent": '腾讯',
      'netease': "网易",
      'xiaomi': "小米",
      'baidu': '百度'
    };
    print(company);
    //先声明，再赋值
    Map<int, String> foodMap = new Map();
    //使用var 声明变量，可以省略变量类型
//    var foodMap=new Map();
    foodMap[0] = '米饭';
    foodMap[1] = '大豆';
    foodMap[2] = '葡萄';
    foodMap[3] = '牛肉';
    print(foodMap);

    //调用可选命名参数函数
    enableFlag(bold: true);
    enableFlag();

    //调用可选位置参数函数
    fun2('小明', '2019冲鸭！');

    //把函数作为参数传递给另一个函数
    food.forEach(printElement);

    //..运算符（级联操作）,使用..调用某个对象的方法（或者成员变量）时，返回值是这个对象本身
    //类似于java的建造者模式
    final person = new Person();
    person
      ..eat()
      ..sleep()
      ..run();

    //控制语句
    int score = 66;
    if (score < 60) {
      print("不及格,重考");
    } else if (score >= 60 && score < 90) {
      print("海星");
    } else {
      print("秀儿，是你吗");
    }

    //try catch
    try {
      print('取余：${9 % 5}');
    } catch (e) {
      print(e);
    }

    try {
      // ~/ 除法,结果为整数且向下取整
      final b = 1 ~/ 0;
    } on IntegerDivisionByZeroException {
      //捕获指定类型的异常
      print('除零异常');
    } finally {
      print('over');
    }

  });
}

void printElement(String e) {
  print("elment:$e \n");
}

//可选命名参数 {param,param,...} 总结：所有参数均为可选
//函数可以使用=为命名参数和位置参数定义默认值。默认值必须是编译时常量。如果没有提供默认值，则默认值为null
void enableFlag({bool bold, bool enable = false}) {
  print("bold:$bold--enable:${enable}");
}

//可选位置参数 用[]它们标记为可选的位置参数 总结：必选参数+可选参数
void fun2(String who, String word, [String place = '北京']) {
  var result = "$who say $word";
  if (place != null) {
    result = "$result at $place";
  }
  print(result);
}

class Person {
  void eat() {
    print("eating...");
  }

  void sleep() {
    print("sleeping...");
  }

  void run() {
    print("running...");
  }
}

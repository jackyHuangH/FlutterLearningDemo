import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Counter increments smoke test", (WidgetTester tester) async{
//    getEmoji(10).forEach((element) {
//      print(element);
//    });
//    getEmojiWithTime(10).forEach(print);

//    fetchEmoji(1).then((value) => print(value));

    fetchEmojis(10).listen((event) {print(event);});
  });
}

//类别	    关键字	  返回类型	  搭档
//多元素同步	sync*	Iterable<T>	yield、yield*
//单元素异步	async	Future<T>	await
//多元素异步	async*	Stream<T>	yield、yield* 、await

Iterable<String> getEmoji(int count) sync* {
  Runes first = Runes("\u{1f47f}");
  for (int i = 0; i < count; i++) {
    yield String.fromCharCodes(first.map((e) => e + i));
  }
}

//yield*后面的表达式是一个Iterable<T>对象
Iterable<String> getEmojiWithTime(int count) sync* {
  yield* getEmoji(count).map((e) => "$e -- ${DateTime.now().toIso8601String()}");
}

//单元素异步
Future<String> fetchEmoji(int count) async {
  Runes first = Runes("\u{1f47f}");
  print("加载开始：${DateTime.now().toIso8601String()}");
  //模拟耗时
  await Future.delayed(Duration(seconds: 2));
  print("加载结束：${DateTime.now().toIso8601String()}");
  return String.fromCharCodes(first.map((e) => e + count));
}

//多元素异步，返回Stream
Stream<String> fetchEmojis(int count) async*{
  for(int i=0;i<count;i++){
    yield await fetchEmoji(count);
  }
}
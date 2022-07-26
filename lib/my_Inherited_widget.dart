import 'package:flutter/material.dart';

// 参考: https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/advanced_inheritedwidget

class MyInheritedWidget extends InheritedWidget {
  final String message;
  final int count;
  // コンストラクタで変数と子Widgetを取る
  const MyInheritedWidget({Key? key, required this.message,required this.count, required Widget child})
      : super(key: key, child: child);

  // O(1)でInheritedWidgetを返却
  static MyInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()
      as MyInheritedWidget;

  // 更新されたかどうかの判定ロジック
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) =>
      // oldWidget.message != message;
      oldWidget.count != count;
}

class MyInheritedWidgetPage extends StatefulWidget {
  const MyInheritedWidgetPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  MyInheritedWidgetPageState createState() => MyInheritedWidgetPageState();
}

class MyInheritedWidgetPageState extends State<MyInheritedWidgetPage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    debugPrint("count:$_counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
        MyInheritedWidget(
            message: 'I am InheritedWidget',
            count: _counter,
            child: const Center(child: WidgetA(tag: 'a'))),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 下位のWidgetAが上位のMyInheritedWidgetの変数を参照している
class WidgetA extends StatelessWidget {
  final String tag;
  const WidgetA({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("build:$tag");

    MyInheritedWidget myInheritedWidget = MyInheritedWidget.of(context); // MyInheritedWidgetと蜜結合になるのが気になる
    String message = myInheritedWidget.message ;
    int count = myInheritedWidget.count;
    return Text("$message count:$count tag:$tag");
  }
}

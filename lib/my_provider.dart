import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 参考: https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/advanced_provider#provider

class MyProviderPage extends StatefulWidget {
  const MyProviderPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  MyProviderPageState createState() => MyProviderPageState();
}

class MyProviderPageState extends State<MyProviderPage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    debugPrint("count:$_counter");
  }

  final Widget _widget = Center(
      child: Consumer<int>(
    builder: (context, value, _) => Text(
      value.toString(),
      style: const TextStyle(fontSize: 100),),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
        // MyInheritedWidget(
        //     message: 'I am InheritedWidget',
        //     count: _counter,
        //     child: const Center(child: WidgetA(tag: 'a'))),
        Provider<int>.value(value: _counter, child: _widget),
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

    // MyInheritedWidget myInheritedWidget = MyInheritedWidget.of(context);
    // String message = myInheritedWidget.message ;
    // int count = myInheritedWidget.count;
    String message = "";
    int count = Provider.of<int>(context);
    return Text("$message count:$count tag:$tag");
  }
}

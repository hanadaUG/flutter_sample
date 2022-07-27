import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// https://qiita.com/kazutxt/items/e6e84957f92aafc472b4
// (1) SliderはProvider.ofでMyDataにアクセスし、値の取得や設定を行う
// (2) MyDataのsetterの中で、notifyListenersでリスナーに変更を通知する
// (3) Consumerが変更を検知して、Textへの値の設定と作り直しを行う

class MyData with ChangeNotifier {
  double _value = 0.5;
  // getter
  double get value => _value;
  // setter
  set value(double value) {
    _value = value;
    notifyListeners(); // (2) Consumerに通知
  }
}

class MySlider extends StatefulWidget {
  const MySlider({Key? key}) : super(key: key);

  @override
  createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    final myData = Provider.of<MyData>(context);

    // value: context.select((MyData myData) => myData.value),
    // onChanged: (value) => context.read<MyData>().value = value);
    return Slider(value: myData.value, onChanged: (value) => myData.value = value); // (1) スライダーの変化によって　MyDataに値をセット

  }
}

class MySliderPage extends StatefulWidget {
  const MySliderPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  MySliderPageState createState() => MySliderPageState();
}

class MySliderPageState extends State<MySliderPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // 通知を検知するため上位に配置
      create: (BuildContext context) => MyData(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title!),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<MyData>( // (3) 通知から画面の数値表示を行っているWidgetを作り直す
                builder: (context, myData, _) => Text(
                  // context.select((MyData myData) => myData.value.toStringAsFixed(2)),
                  myData.value.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 100),
                ),
              ),
              const MySlider(),
            ],
          )),
    );
  }
}
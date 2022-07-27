import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/advanced_riverpod

class MyData extends StateNotifier<double> {
  MyData() : super(0.5);
  void changState(newState) => state = newState;
}

// 1.グローバル変数にProviderを設定
final _myDataProvider =
StateNotifierProvider<MyData, double>((ref) => MyData());

// 2.ProviderScopeを設定

class MyRiverpodSliderPage extends StatefulWidget {
  const MyRiverpodSliderPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  MyRiverpodSliderPageState createState() => MyRiverpodSliderPageState();
}

class MyRiverpodSliderPageState extends State<MyRiverpodSliderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 3.ConsumerWidgetを使い、watchを使えるようにする
          Consumer(builder: (context, ref, child) {
            return Text(
              // 4.watch関数にプロバイダーを渡し、stateを取り出す
              ref.watch(_myDataProvider).toStringAsFixed(2),
              style: const TextStyle(fontSize: 100),
            );
          }),
          Consumer(builder: (context, ref, child) {
            return Slider(
                value: ref.watch(_myDataProvider),
                // 5.context.readにプロバイダーのnotifierを与えて、メソッドを呼び出す
                onChanged: (value) =>
                    ref.read(_myDataProvider.notifier).changState(value));
          }),
        ],
      ),
    );
  }
}

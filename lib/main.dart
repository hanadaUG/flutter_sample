import 'package:flutter/material.dart';
import 'package:flutter_sample/my_Inherited_widget.dart';
import 'package:flutter_sample/my_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // この段階のcontextはMaterialAppの情報を持っていないのでNavigatorが使用できない
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialAppが親になっているのでcontextはMaterialAppの情報を持っておりNavigatorが使用可能
    return Scaffold(
      appBar: AppBar(
        title: const Text('サンプル'),
      ),
      body: Center(
          child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
                onPressed: () {
                  debugPrint('InheritedWidget');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyInheritedWidgetPage(title: 'InheritedWidget',)));
                },
                child: const Text('InheritedWidget')),
            OutlinedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyProviderPage(title: 'Provider',)));
            }, child: const Text('Provider')),
            OutlinedButton(onPressed: () => {}, child: const Text('Riverpod')),
          ],
        ),
      )),
    );
  }
}

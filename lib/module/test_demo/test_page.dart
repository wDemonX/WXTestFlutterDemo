import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:viawallet_flutter/http/dio_util.dart';
import 'package:viawallet_flutter/http/viawallet_response.dart';
import 'package:viawallet_flutter/model/exchange_record.dart';
import 'package:viawallet_flutter/model/rate.dart';
import 'package:viawallet_flutter/platform/viawallet_method_channel.dart';

/// Test Page
class TestPage extends StatefulWidget {
  const TestPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _counter = 0;
  final CancelToken _cancelToken = CancelToken();


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  
  @override
  void initState() {
    super.initState();
  }

  void _fetchDataFromServer() async {
    ViaResponse result = await DioUtil().request("res/exchange/CNY", cancelToken: _cancelToken);
    if(result.code == ViaResponseCode.success) {
      List<Rate> list = List.from(result.data).map((objJson) => Rate.fromJson(objJson)).toList();
      debugPrint("name: ${list[0].name} : displayClose: ${list[0].displayClose}");
      Fluttertoast.showToast(msg: "name: ${list[0].name} : displayClose: ${list[0].displayClose}");
    } else {
      final message = result.message ?? "";
      if(message.isEmpty) return;
      Fluttertoast.showToast(msg: message);
    }
  }

  void _fetchExchangeRecord() async {
    ViaResponse result = await DioUtil().request("res/exchanges/queryAllOrder", params: {'page': 1, 'limit': 20}, cancelToken: _cancelToken);
    if(result.code == ViaResponseCode.success) {
      ExchangeRecord record = ExchangeRecord.fromJson(result.data);
      debugPrint("data: ${record.total}");
      Fluttertoast.showToast(msg: "data: ${record.total}");
    } else {
      final message = result.message ?? "";
      if(message.isEmpty) return;
      Fluttertoast.showToast(msg: message);
    }
  }

  void _fetchPlatformInfo() async {
    String deviceId = await ViaWalletMethodChannel.platformDeviceId;
    String channel = await ViaWalletMethodChannel.platformChannel;
    String wid = await ViaWalletMethodChannel.platformWid;
    debugPrint("deviceId $deviceId");
    debugPrint("channel $channel");
    debugPrint("wid $wid");
    Fluttertoast.showToast(msg: wid);
  }

  @override
  void dispose() {
    DioUtil().cancelRequests(_cancelToken);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  _fetchExchangeRecord,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
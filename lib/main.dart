import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'common/translations/translation_dictionary.dart';
import 'module/exchange_record/exchange_record_page.dart';
import 'module/test_demo/test_page.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getx https://github.com/jonataslaw/getx/blob/master/documentation/zh_CN/route_management.md
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      translations: Dictionary(), // https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md
      locale: window.locale, //读取系统语言
      fallbackLocale: const Locale('zh', 'CN'),
      initialRoute: '/exchange_record',
      getPages: [
        GetPage(name: '/test_page', page: () => const TestPage(title: "TestPage")),
        GetPage(name: '/exchange_record', page: () => const ExchangeRecordPage()),
        // GetPage(
        //     name: '/third',
        //     page: () => Third(),
        //     transition: Transition.zoom
        // ),
      ],
      // home: const ExchangeRecordPage(),
    );
  }
}



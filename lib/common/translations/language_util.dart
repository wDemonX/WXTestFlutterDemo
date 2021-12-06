import 'dart:ui';

/// 获取 Accept-Language.
String getAcceptLanguage() {
  String localeString = window.locale.toString();

  switch(localeString) {
    case "zh_CN":
      return 'zh_Hans_CN';

    case "zh_TW":
    case "zh_HK":
      return 'zh_Hant_HK';

    default:
      return 'en_US';
  }
}
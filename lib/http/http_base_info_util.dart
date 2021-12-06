import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info/package_info.dart';
import 'package:viawallet_flutter/platform/viawallet_method_channel.dart';

Future<Map<String, dynamic>> commonHeaders() async {

  bool isIOS = Platform.isIOS;
  String platform = isIOS ? "iOS" : "Android";

  // String deviceId = "1b40c97c36ce3f0d";
  // String channel = "ViaBTC";
  // String wid = "5d3e924233063c35215b3e11";
  // String lang = "zh_Hans_CN";
  String deviceId = await ViaWalletMethodChannel.platformDeviceId;
  String channel = await ViaWalletMethodChannel.platformChannel;
  String wid = await ViaWalletMethodChannel.platformWid;
  String lang = await ViaWalletMethodChannel.platformLanguage;

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  final String userAgent = await platformUserAgent();

  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  Map<String, dynamic> headers = {
    "Accept-Language": lang,
    "X-Platform": platform,
    "X-Version": version,
    "X-Build": buildNumber,
    "X-DeviceID": deviceId,
    "X-Channel": channel,
    "User-Agent": userAgent,
    "X-WID": wid,
  };

  return headers;
}

Future<String> platformUserAgent() async {

  bool isIOS = Platform.isIOS;
  String platform = isIOS ? "iOS" : "Android";

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();


  String versionName = packageInfo.version;
  String versionCode = packageInfo.buildNumber;
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;


  String systemVersion = "";

  if(isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    systemVersion = iosInfo.systemVersion ?? "";
  } else {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    systemVersion = androidInfo.version.release ?? "";
  }

  String httpLib = isIOS ? "Alamofire/5.4.3" : "okhttp3/3.12.3";

  String userAgent = "$appName/$versionName($packageName;build:$versionCode;$platform $systemVersion)$httpLib";

  return userAgent;
}


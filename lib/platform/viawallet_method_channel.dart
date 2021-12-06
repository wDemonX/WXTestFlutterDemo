import 'dart:async';
import 'package:flutter/services.dart';

/// native 通信接口
class ViaWalletMethodChannel {
  static const MethodChannel _channel = MethodChannel('com.viabtc.wallet/native_info');

  static Future<String> get platformDeviceId async {
    final String? version = await _channel.invokeMethod('getDeviceId');
    return version ?? "";
  }

  static Future<String> get platformChannel async {
    final String? channel = await _channel.invokeMethod('getChannel');
    return channel ?? "";
  }

  static Future<String> get platformWid async {
    final String? wid = await _channel.invokeMethod('getWid');
    return wid ?? "";
  }

  static Future<String> get platformLanguage async {
    final String? wid = await _channel.invokeMethod('getLanguage');
    return wid ?? "";
  }

}

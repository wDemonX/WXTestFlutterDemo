import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// DioInterceptors
class DioInterceptors extends Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch(err.type) {
      // 连接超时
      case DioErrorType.connectTimeout:
        {
          debugPrint("连接超时");
          debugPrint(err.message);
        }
        break;
      // 响应超时
      case DioErrorType.receiveTimeout:
        {
          debugPrint("响应超时");
          debugPrint(err.message);
        }
        break;
      // 请求超时
      case DioErrorType.sendTimeout:
        {
          debugPrint("请求超时");
          debugPrint(err.message);
        }
        break;
      // 请求取消
      case DioErrorType.cancel:
        {
          debugPrint("请求取消");
          debugPrint(err.message);
        }
        break;
      // 404/503错误 等内部错误
      case DioErrorType.response:
        {
          debugPrint("内部错误");
          debugPrint(err.message);
        }
        break;
      // other 其他错误类型
      case DioErrorType.other:
        {
          debugPrint("未知错误");
          debugPrint(err.message);
          //SocketException: Failed host lookup: 'www.baidu.co' (OS Error: No address associated with hostname, errno = 7)
        }
        break;
    }
    super.onError(err, handler);
  }
}
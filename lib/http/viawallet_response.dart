import 'package:dio/dio.dart';

/// ViaWallet Response
class ViaResponse<T> {
  /// 消息
  String? message;
  /// 自定义code
  int? code;
  /// 接口返回的数据
  T? data;

  ViaResponse({
    this.message,
    this.data,
    this.code,
  });

  static Future<ViaResponse> convertData(Response response) {
    ViaResponse viaResp = ViaResponse(
      code: response.data['code'],
      data: response.data['data'],
      message: response.data['message'],
    );
    return Future.value(viaResp);
  }

  static Future<ViaResponse> convertError(String message) {
    ViaResponse viaResp = ViaResponse(
      code: ViaResponseCode.error,
      message: message,
    );
    return Future.value(viaResp);
  }

  static Future<ViaResponse> convertDioError(DioError err) {
    String message = "";

    switch(err.type) {
      case DioErrorType.connectTimeout:
        {
          message = "连接超时";
        }
        break;
      case DioErrorType.receiveTimeout:
        {
          message = "响应超时";
        }
        break;
      case DioErrorType.sendTimeout:
        {
          message = "请求超时";
        }
        break;
      case DioErrorType.cancel:
        {
          message = "请求取消";
        }
        break;
      // 404/503错误 等内部错误
      case DioErrorType.response:
        {
          // or 服务器繁忙请稍后重试
          message = "内部错误";
        }
        break;
      // other 其他错误类型
      case DioErrorType.other:
        {
          message = "未知错误";
        }
        break;
    }

    ViaResponse viaResp = ViaResponse(
      code: ViaResponseCode.error,
      message: message,
    );
    return Future.value(viaResp);
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"message\":\"$message\"");
    sb.write(",\"errorMsg\":\"$code\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

class ViaResponseCode {
  /// 成功
  static const int success = 0;
  /// 错误
  static const int error = 0;
}
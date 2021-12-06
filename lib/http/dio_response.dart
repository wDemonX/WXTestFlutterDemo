
/// 通用 Response
class DioResponse<T> {
  /// 消息
  String? message;
  /// 自定义code
  int? code;
  /// 接口返回的数据
  T? data;

  DioResponse({
    this.message,
    this.data,
    this.code,
  });

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

class DioResponseCode {
  /// 成功
  static const int success = 0;
  /// 错误
  static const int error = 1;
}
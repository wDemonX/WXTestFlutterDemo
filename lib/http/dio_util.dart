import 'package:dio/dio.dart';
import 'package:viawallet_flutter/http/viawallet_response.dart';

import 'dio_interceptors.dart';
import 'dio_method.dart';
import 'http_base_info_util.dart';

/// http 工具类
class DioUtil {
  /// 连接超时时间
  static const int connectTimeout = 15 * 1000;

  /// 响应超时时间
  static const int receiveTimeout = 15 * 1000;

  /// 请求的URL前缀
  // static String baseUrl = "http://47.112.185.252:8080/";
  static String baseUrl = "https://viawallet.com/";

  late Dio _dio;

  DioUtil._internal() {
    /// 初始化基本选项
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout);

    /// 初始化dio
    _dio = Dio(options);

    /// 添加转换器
    _dio.transformer = DefaultTransformer();

    /// 添加拦截器
    _dio.interceptors.add(DioInterceptors());

    /// 添加拦截器
    _dio.interceptors.add(LogInterceptor());
  }

  factory DioUtil() => _instance;

  static late final DioUtil _instance = DioUtil._internal();

  Future<ViaResponse> request(
    String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };

    Map<String, dynamic> headers = await commonHeaders();
    Options options = Options(method: _methodValues[method], headers: headers);

    try {
      Response response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken
      );

      if(response.statusCode == 200 && response.data != null && response.data != 'null') {
        return ViaResponse.convertData(response);
      } else {
        return ViaResponse.convertError("${response.statusCode.toString()}:${response.statusMessage}");
      }
    } on DioError catch (e) {
      return ViaResponse.convertDioError(e);
    } catch (e) {
      return ViaResponse.convertError(e.toString());
    }
  }

  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

}

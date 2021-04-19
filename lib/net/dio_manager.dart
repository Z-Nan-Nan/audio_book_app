import 'package:dio/dio.dart';
import 'dart:async';

/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class HttpUtils {

  /// global dio object
  static Dio dio;

  /// default options
  // static const String API_PREFIX = 'http://www.routereading.com';
  static const String API_PREFIX = 'http://localhost:3000';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  var userToken = '';

  static Future<Map> request (
      String url,
      { data, method }) async {
    data = data ?? {};
    method = method ?? 'GET';
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());
    Dio dio = createInstance();
    var result;
    try {
      Response response = await dio.request(url, data: data, options: new Options(method: method));
      result = response.data;
      print('响应数据：' + response.toString());
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
    }
    return result;
  }

  static Dio createInstance () {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = new Dio(options);
    }
    return dio;
  }

  /// 清空 dio 对象
  static clear () {
    dio = null;
  }

}
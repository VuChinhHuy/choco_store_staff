// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

import '../../utils/pretty_dio_logger.dart';
import 'constant_api.dart';
import 'exception/error.dart';

class RestClient {
  static const TIMEOUT = 60000;
  static const ENABLE_LOG = true;
  static const ACCESS_TOKEN_HEADER = 'Authorization';
  // singleton
  static final RestClient instance = RestClient._internal();

  factory RestClient() {
    return instance;
  }
  RestClient._internal();

  late String baseUrl;
  late Map<String, dynamic> headers;

  void init(String baseUrl, {String? accessToken}) {
    this.baseUrl = baseUrl;
    headers = {
      'Content-Type': 'application/json',
    };
    if (accessToken != null) setToken(accessToken);
  }

  void setToken(String token) {
    headers[ACCESS_TOKEN_HEADER] = "Bearer $token";
  }

  void clearToken() {
    headers.remove(ACCESS_TOKEN_HEADER);
  }

  static Dio getDio({bool isUpload = false}) {
    var dio = Dio(instance.getDioBaseOption(isUpload: isUpload));
    if (ENABLE_LOG) {
      dio.interceptors
          .add(PrettyDioLogger(requestBody: true, responseBody: false));
    }
    dio.interceptors.add(AppInterceptors(dio));
    return dio;
  }

  BaseOptions getDioBaseOption({bool isUpload = false}) {
    return BaseOptions(
      baseUrl: isUpload ? BASE_URL : instance.baseUrl,
      connectTimeout: TIMEOUT,
      receiveTimeout: TIMEOUT,
      headers: instance.headers,
      responseType: ResponseType.json,
    );
  }
}
